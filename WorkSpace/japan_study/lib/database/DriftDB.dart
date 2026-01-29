import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:japan_study/database/DatabaseRepository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/Models/Lyric.dart';
import 'package:japan_study/Models/Display/StudiedVideoUI.dart';
import 'package:japan_study/Service/Youtube/YoutubeSearcher.dart';
import 'package:japan_study/database/Account_Data/AccountData.dart';
import 'package:japan_study/database/Global_Data/GlobalVideoInfo.dart';
import 'package:japan_study/database/Global_Data/GlobalLyricsData.dart';
import 'package:japan_study/database/Local_Models/LocalUser.dart';
import 'package:japan_study/database/Local_Models/LocalStudyHistory.dart';
import 'package:japan_study/database/Local_Models/LocalVideoPrefs.dart';
import 'package:japan_study/database/Local_Models/LocalVideos.dart';
import 'package:japan_study/database/Local_Models/LocalLyrics.dart';
import 'package:japan_study/utils/uuid.dart';

part 'DriftDB.g.dart';

@DriftDatabase(
  tables: [
    LocalStudyHistory,
    LocalVideoPrefs,
    LocalUsers,
    LocalVideos,
    LocalLyrics,
  ],
)
class DriftDB extends _$DriftDB implements DatabaseRepository {
  DriftDB() : super(_openConnection());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _deviceUid;

  Future<String> _getUid() async {
    _deviceUid ??= await DeviceUtil.getDeviceUid();
    return _deviceUid!;
  }

  @override
  int get schemaVersion => 1;

  // ===========================================================================
  // Initialize
  // ===========================================================================

  @override
  Future<void> saveInitialize() async {
    final uid = await _getUid();

    final guest = await (select(
      localUsers,
    )..where((t) => t.uid.equals(uid))).getSingleOrNull();

    if (guest == null) {
      await into(localUsers).insert(
        LocalUsersCompanion.insert(
          uid: uid,
          email: const Value(''),
          displayName: const Value('Guest'),
          photoUrl: const Value(null),
          lastLogin: Value(DateTime.now()),
        ),
      );
    }
  }

  // ===========================================================================
  // Get
  // ===========================================================================

  @override
  Future<AccountData?> getAccount(String uid) async {
    final user = await (select(
      localUsers,
    )..where((t) => t.uid.equals(uid))).getSingleOrNull();

    if (user == null) return null;

    final favQuery = select(localVideoPrefs).join([
      leftOuterJoin(
        localVideos,
        localVideos.youtubeVideoId.equalsExp(localVideoPrefs.youtubeVideoId),
      ),
    ]);

    favQuery.where(
      localVideoPrefs.uid.equals(uid) & localVideoPrefs.isFavorite.equals(true),
    );

    final favResult = await favQuery.get();

    final favList = favResult
        .map((row) {
          final video = row.readTableOrNull(localVideos);
          if (video == null) return null;

          return VideoInfo(
            youtubeVideoId: video.youtubeVideoId,
            title: video.title,
            artist: video.artist,
            // ⚠️ "URL 전부 대문자로 바꿨어" -> DB 컬럼명 확인
            thumbnailUrl: video.thumbnailUrl,
          );
        })
        .whereType<VideoInfo>()
        .toList();

    return AccountData(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName ?? 'Guest',
      photoUrl: user.photoUrl,
      lastLogin: user.lastLogin ?? DateTime.now(),
      favoriteYoutubeVideos: favList,
      frequentlyListenedVideos: const [],
      dailyAiCount: 0,
      dailyLyricCount: 0,
    );
  }

  @override
  Stream<List<VideoInfo>> getFrequentlyVideos() {
    // youtube에서 영상을 가져올때만 Firebase에서 가사정보까지 가져오고있는데,
    // 여기서도 추가되어 있던 노래가 실시간으로 서버에 가사가 들어오면 한번 더 눌렀을때 가사가 생기게 해야함.
    return select(localVideos).watch().map((rows) {
      return rows.map((video) {
        return VideoInfo(
          youtubeVideoId: video.youtubeVideoId,
          title: video.title,
          artist: video.artist,
          thumbnailUrl: video.thumbnailUrl,
        );
      }).toList();
    });
  }

  @override
  Future<int> getTodayCompletedCount() async {
    // 1. 오늘 날짜 범위 계산
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day); // 오늘 00:00:00
    final endOfToday = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
    ); // 오늘 23:59:59

    // 2. 현재 사용자(기기) ID 가져오기
    // (DriftDB는 로컬이지만, 여러 계정이 로그인/아웃 할 수 있으므로 현재 UID 기준 필터링이 안전함)
    // 만약 UID 구분이 필요 없다면 .where((t) => ...) 부분에서 uid 조건만 빼면 됩니다.
    final uid = await _getUid();

    // 3. DB 쿼리 실행
    // SELECT COUNT(*) FROM localStudyHistory WHERE studiedAt BETWEEN start AND end AND uid = currentUid
    final count =
        await (select(localStudyHistory)..where(
              (t) =>
                  t.studiedAt.isBetween(
                    Variable(startOfToday),
                    Variable(endOfToday),
                  ) & // 날짜 조건
                  t.uid.equals(uid),
            )) // 내 기록만 카운트
            .get();

    return count.length;
  }

  @override
  Future<bool> isVideoCompletedToday(String youtubeVideoId) async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day);

    final list =
        await (select(localStudyHistory)..where(
              (t) =>
                  t.youtubeVideoId.equals(youtubeVideoId) &
                  t.studiedAt.isBiggerOrEqualValue(start),
            ))
            .get();

    return list.isNotEmpty;
  }

  @override
  Future<List<VideoInfo>> getFavoriteVideos() async {
    final uid = await _getUid();

    final query = select(localVideoPrefs).join([
      leftOuterJoin(
        localVideos,
        localVideos.youtubeVideoId.equalsExp(localVideoPrefs.youtubeVideoId),
      ),
    ]);

    query.where(
      localVideoPrefs.uid.equals(uid) & localVideoPrefs.isFavorite.equals(true),
    );

    final result = await query.get();

    return result
        .map((row) {
          final video = row.readTableOrNull(localVideos);
          if (video == null) return null;

          return VideoInfo(
            youtubeVideoId: video.youtubeVideoId,
            title: video.title,
            artist: video.artist,
            thumbnailUrl: video.thumbnailUrl,
          );
        })
        .whereType<VideoInfo>()
        .toList();
  }

  @override
  Stream<List<StudiedVideoUI>> getStudiedVideosUI() async* {
    final uid = await _getUid();

    final query = select(localStudyHistory).join([
      innerJoin(
        localVideos,
        localVideos.youtubeVideoId.equalsExp(localStudyHistory.youtubeVideoId),
      ),
      leftOuterJoin(
        localVideoPrefs,
        localVideoPrefs.youtubeVideoId.equalsExp(
              localStudyHistory.youtubeVideoId,
            ) &
            localVideoPrefs.uid.equals(uid),
      ),
    ]);

    query.orderBy([
      OrderingTerm(
        expression: localStudyHistory.studiedAt,
        mode: OrderingMode.desc,
      ),
    ]);

    yield* query.watch().map((rows) {
      return rows.map((row) {
        final history = row.readTable(localStudyHistory);
        final video = row.readTable(localVideos);
        final prefs = row.readTableOrNull(localVideoPrefs);

        return StudiedVideoUI(
          recordId: history.recordId,
          studiedAt: history.studiedAt,
          video: VideoInfo(
            youtubeVideoId: video.youtubeVideoId,
            title: video.title,
            artist: video.artist,
            thumbnailUrl: video.thumbnailUrl,
          ),
          isFavorite: prefs?.isFavorite ?? false,
        );
      }).toList();
    });
  }

  @override
  Future<VideoInfo> getVideoFromYoutube(YoutubeVideo video) async {
    // 1. [Local Check] 로컬에 이미 저장된 놈인지 확인
    final local = await (select(
      localVideos,
    )..where((t) => t.youtubeVideoId.equals(video.videoId))).getSingleOrNull();

    // 로컬에 있으면 바로 리턴 (가사 가져오기 시도조차 안 함)
    if (local != null) {
      return VideoInfo(
        youtubeVideoId: local.youtubeVideoId,
        title: local.title,
        artist: local.artist,
        thumbnailUrl: local.thumbnailUrl ?? '',
      );
    }

    // 2. [Global Check] 로컬에 없으니 Firebase 확인
    try {
      final doc = await _firestore
          .collection('global_videos')
          .doc(video.videoId.trim())
          .get();

      if (doc.exists) {
        // Firebase에 데이터가 존재함!
        final globalData = GlobalVideoInfo.fromMap(doc.data()!);
        List<GlobalLyricsData> lyricsList = [];

        // ★★★ 핵심: 영상 정보가 Firebase에 있다면, 가사도 지금 즉시 가져옴 ★★★
        if (globalData.hasLyrics) {
          final lyricsSnap = await _firestore
              .collection('global_videos')
              .doc(video.videoId.trim())
              .collection('lyrics')
              .orderBy('order')
              .get();

          lyricsList = lyricsSnap.docs
              .map((e) => GlobalLyricsData.fromMap(e.data()))
              .toList();
        }

        // 3. [Save] 영상정보 + 가사정보를 로컬에 통째로 저장 (Transaction)
        await saveGlobalDataWithLyrics(video: globalData, lyrics: lyricsList);

        return VideoInfo(
          youtubeVideoId: globalData.youtubeVideoId,
          title: globalData.title,
          artist: globalData.artist,
          thumbnailUrl: globalData.thumbnailUrl ?? '',
        );
      }
    } catch (e) {
      // 에러 발생 시 무시하고 신규 생성 로직으로 이동
    }

    // 4. [New] Firebase에도 없음 -> 깡통 데이터 생성 후 로컬 저장
    final created = GlobalVideoInfo(
      youtubeVideoId: video.videoId,
      title: video.title,
      artist: video.artist,
      thumbnailUrl: video.thumbnailUrl ?? '',
      hasLyrics: false,
      isAnalyzed: false,
    );

    // 가사 없이 영상 정보만 저장
    await saveGlobalDataWithLyrics(video: created, lyrics: []);

    return VideoInfo(
      youtubeVideoId: created.youtubeVideoId,
      title: created.title,
      artist: created.artist,
      thumbnailUrl: created.thumbnailUrl ?? '',
    );
  }

  @override
  Future<GlobalVideoInfo?> getGlobalVideo(String youtubeVideoId) async {
    final local = await (select(
      localVideos,
    )..where((t) => t.youtubeVideoId.equals(youtubeVideoId))).getSingleOrNull();

    if (local != null) {
      return GlobalVideoInfo(
        youtubeVideoId: local.youtubeVideoId,
        title: local.title,
        artist: local.artist,
        thumbnailUrl: local.thumbnailUrl,
        hasLyrics: local.hasLyrics,
        isAnalyzed: local.isAnalyzed,
      );
    }

    try {
      final doc = await _firestore
          .collection('global_videos')
          .doc(youtubeVideoId)
          .get();

      if (doc.exists) {
        final data = GlobalVideoInfo.fromMap(doc.data()!);
        await saveGlobalVideo(data);
        return data;
      }
    } catch (_) {}

    return null;
  }

  @override
  Future<List<Lyric>> getLyricsForVideo(String youtubeVideoId) async {
    // ---------------------------------------------------------
    // 1. [Local Check] 로컬 DB 조회
    // ---------------------------------------------------------
    final localData =
        await (select(localLyrics)
              ..where((t) => t.youtubeVideoId.equals(youtubeVideoId))
              ..orderBy([(t) => OrderingTerm(expression: t.order)]))
            .get();

    if (localData.isNotEmpty) {
      print("RUD: [Local] 로컬 캐시에서 가사 로드 완료 ($youtubeVideoId)");
      return localData
          .map(
            (e) => Lyric.fromDb(
              content: e.content,
              translation: e.translation,
              notes: e.notes,
              startTimeMs: e.startTimeMs,
            ),
          )
          .toList();
    }

    // ---------------------------------------------------------
    // 2. [Cloud Check] 로컬에 없으면 Firebase 조회 (Fallback)
    // ---------------------------------------------------------
    print("RUD: [Local] 가사 없음 -> [Cloud] 서버 조회 시도...");

    try {
      // Global Video의 Lyrics 컬렉션 조회
      final snap = await _firestore
          .collection('global_videos')
          .doc(youtubeVideoId)
          .collection('lyrics')
          .orderBy('order')
          .get();

      // A. [Cloud Found] 서버에 가사가 존재하는 경우
      if (snap.docs.isNotEmpty) {
        print("RUD: [Cloud] 서버에서 가사 발견! (${snap.docs.length}줄) -> 로컬 저장 시작");

        // 1) 데이터 매핑 (Firestore -> Model)
        final serverLyrics = snap.docs
            .map((e) => GlobalLyricsData.fromMap(e.data()))
            .toList();

        // 2) 로컬 DB 동기화 (Transaction)
        //    (이미 frequency에 있다면 localVideos에는 존재할 것이므로 가사만 넣으면 됨)
        await transaction(() async {
          // 영상 정보의 hasLyrics 플래그를 true로 업데이트
          await (update(localVideos)
                ..where((t) => t.youtubeVideoId.equals(youtubeVideoId)))
              .write(const LocalVideosCompanion(hasLyrics: Value(true)));

          // 기존 가사 삭제 (혹시 모를 찌꺼기 제거)
          await (delete(
            localLyrics,
          )..where((t) => t.youtubeVideoId.equals(youtubeVideoId))).go();

          // 새 가사 대량 삽입
          await batch((batch) {
            batch.insertAll(
              localLyrics,
              serverLyrics.map(
                (item) => LocalLyricsCompanion.insert(
                  youtubeVideoId: youtubeVideoId,
                  order: item.order,
                  content: item.content,
                  translation: item.translation,
                  notes: Value(item.notes),
                  startTimeMs: Value(item.startTimeMs),
                ),
              ),
            );
          });
        });

        print("RUD: [Sync] 로컬 DB 동기화 완료. 가사를 반환합니다.");

        // 3) 결과 반환 (UI용 모델로 변환)
        return serverLyrics
            .map(
              (e) => Lyric.fromDb(
                content: e.content,
                translation: e.translation,
                notes: e.notes,
                startTimeMs: e.startTimeMs,
              ),
            )
            .toList();
      }
      // B. [Empty] 서버에도 가사가 없는 경우
      else {
        print("RUD: [Cloud] 서버 확인 결과: 가사 없음 (빈 리스트 반환)");
        return [];
      }
    } catch (e) {
      print("RUD: [Error] 가사 조회 중 오류 발생 - $e");
      return [];
    }
  }

  @override
  Future<bool> getFavoriteStatus(String videoId) async {
    final uid = await _getUid();

    final pref =
        await (select(localVideoPrefs)..where(
              (t) => t.uid.equals(uid) & t.youtubeVideoId.equals(videoId),
            ))
            .getSingleOrNull();

    return pref?.isFavorite ?? false;
  }

  // ===========================================================================
  // Save / Update
  // ===========================================================================

  @override
  Future<void> saveAccount(User user, String? deviceId) async {
    final uid = await _getUid();

    await (update(localUsers)..where((t) => t.uid.equals(uid))).write(
      LocalUsersCompanion(lastLogin: Value(DateTime.now())),
    );
  }

  @override
  Future<void> saveGlobalVideo(GlobalVideoInfo video) async {
    await into(localVideos).insertOnConflictUpdate(
      LocalVideosCompanion.insert(
        youtubeVideoId: video.youtubeVideoId,
        title: video.title,
        artist: video.artist,
        thumbnailUrl: video.thumbnailUrl, // Global모델이 Url이면 Url, URL이면 URL로 수정
        hasLyrics: Value(video.hasLyrics),
        isAnalyzed: Value(video.isAnalyzed),
      ),
    );
  }

  @override
  Future<void> saveStudyRecord(String youtubeVideoId) async {
    final uid = await _getUid();

    await into(localStudyHistory).insert(
      LocalStudyHistoryCompanion.insert(
        recordId: Value(DateTime.now().microsecondsSinceEpoch),
        uid: uid,
        youtubeVideoId: youtubeVideoId,
        studiedAt: DateTime.now(),
      ),
    );
  }

  Future<void> saveGlobalDataWithLyrics({
    required GlobalVideoInfo video,
    required List<GlobalLyricsData> lyrics,
  }) async {
    return transaction(() async {
      // A. 영상 정보 저장 (LocalVideos)
      await into(localVideos).insertOnConflictUpdate(
        LocalVideosCompanion.insert(
          youtubeVideoId: video.youtubeVideoId,
          title: video.title,
          artist: video.artist,
          thumbnailUrl: video.thumbnailUrl,
          hasLyrics: Value(video.hasLyrics),
          isAnalyzed: Value(video.isAnalyzed),
        ),
      );

      // B. 가사 정보 저장 (LocalLyrics)
      if (lyrics.isNotEmpty) {
        // 기존 가사 삭제 (중복 방지)
        await (delete(
          localLyrics,
        )..where((t) => t.youtubeVideoId.equals(video.youtubeVideoId))).go();

        // 새 가사 Batch Insert
        await batch((batch) {
          batch.insertAll(
            localLyrics,
            lyrics.map(
              (item) => LocalLyricsCompanion.insert(
                youtubeVideoId: video.youtubeVideoId,
                order: item.order,
                content: item.content,
                translation: item.translation,
                notes: Value(item.notes),
                startTimeMs: Value(item.startTimeMs),
              ),
            ),
          );
        });
      }
    });
  }

  @override
  Future<void> updateFavoriteStatus(VideoInfo video, bool status) async {
    final uid = await _getUid();

    final exists =
        await (select(localVideos)
              ..where((t) => t.youtubeVideoId.equals(video.youtubeVideoId)))
            .getSingleOrNull();

    if (exists == null) {
      await saveGlobalVideo(
        GlobalVideoInfo(
          youtubeVideoId: video.youtubeVideoId,
          title: video.title,
          artist: video.artist,
          thumbnailUrl: video.thumbnailUrl,
          hasLyrics: false,
          isAnalyzed: false,
        ),
      );
    }

    await into(localVideoPrefs).insertOnConflictUpdate(
      LocalVideoPrefsCompanion.insert(
        uid: uid,
        youtubeVideoId: video.youtubeVideoId,
        isFavorite: Value(status),
      ),
    );
  }

  // ✅ 검색 정보 업데이트 (필수)
  @override
  Future<void> updateSearchedInfo({
    required String youtubeVideoId,
    required String searchedArtist,
    required String searchedTitle,
  }) async {
    final uid = await _getUid();

    final entry =
        await (select(localVideoPrefs)..where(
              (t) =>
                  t.uid.equals(uid) & t.youtubeVideoId.equals(youtubeVideoId),
            ))
            .getSingleOrNull();

    if (entry != null) {
      await (update(localVideoPrefs)..where(
            (t) => t.uid.equals(uid) & t.youtubeVideoId.equals(youtubeVideoId),
          ))
          .write(
            LocalVideoPrefsCompanion(
              searchedTitle: Value(searchedTitle),
              searchedArtist: Value(searchedArtist),
            ),
          );
    } else {
      await into(localVideoPrefs).insert(
        LocalVideoPrefsCompanion.insert(
          uid: uid,
          youtubeVideoId: youtubeVideoId,
          searchedTitle: Value(searchedTitle),
          searchedArtist: Value(searchedArtist),
          isFavorite: const Value(false),
        ),
      );
    }
  }

  @override
  Future<void> deleteStudiedRecord(int recordId) async {
    await (delete(
      localStudyHistory,
    )..where((t) => t.recordId.equals(recordId))).go();
  }

  // ===========================================================================
  // Unused
  // ===========================================================================

  @override
  Future<void> saveFrequentlyVideo(VideoInfo video) async {
    // 1. 이미 저장된 비디오인지 확인
    final exists =
        await (select(localVideos)
              ..where((t) => t.youtubeVideoId.equals(video.youtubeVideoId)))
            .getSingleOrNull();

    if (exists != null) {
      // 2. 이미 있으면: 제목, 가수, 썸네일 정보만 최신화 (가사 분석 여부 등 기존 데이터 보존)
      await (update(
        localVideos,
      )..where((t) => t.youtubeVideoId.equals(video.youtubeVideoId))).write(
        LocalVideosCompanion(
          title: Value(video.title),
          artist: Value(video.artist),
          thumbnailUrl: Value(video.thumbnailUrl),
        ),
      );
    } else {
      // 3. 없으면: localVideos에 신규 추가
      await into(localVideos).insert(
        LocalVideosCompanion.insert(
          youtubeVideoId: video.youtubeVideoId,
          title: video.title,
          artist: video.artist,
          thumbnailUrl: video.thumbnailUrl,
          hasLyrics: const Value(false),
          isAnalyzed: const Value(false),
        ),
      );
    }
  }

  @override
  Future<void> insertLyricsData(String id, List<Lyric> l) async {}

  @override
  Future<void> updateDailyCount(String fieldName) async {}

  @override
  Future<void> updateAnalyzedLyrics(String id, List<Lyric> l) async {}

  @override
  Future<void> updateLyricsData(String id, List<Lyric> l) async {}

  @override
  Future<void> updateIsAnalyzed(String id, bool s) async {}

  @override
  Future<void> updateIsLyrics(String id, bool s) async {}
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    return NativeDatabase(File(p.join(dir.path, 'db.sqlite')));
  });
}
