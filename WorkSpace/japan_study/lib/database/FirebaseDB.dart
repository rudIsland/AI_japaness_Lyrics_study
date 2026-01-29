import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:japan_study/database/DatabaseRepository.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/Models/Lyric.dart';
import 'package:japan_study/database/Account_Data/AccountData.dart';
import 'package:japan_study/database/Global_Data/GlobalVideoInfo.dart';
import 'package:japan_study/database/Global_Data/GlobalLyricsData.dart';
import 'package:japan_study/Models/Display/StudiedVideoUI.dart';

import 'package:japan_study/Service/Youtube/YoutubeSearcher.dart';

class FirebaseDB implements DatabaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get _uid => _auth.currentUser?.uid ?? '';

  @override
  Future<void> saveInitialize() async => print("RUD: DB 초기화 완료");

  // --- [ 1. Get 그룹 ] ---

  @override
  Future<AccountData?> getAccount(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists ? AccountData.fromMap(doc.data()!) : null;
  }

  @override
  Stream<List<VideoInfo>> getFrequentlyVideos() {
    // 1. UID가 비어있는지 먼저 체크합니다. [cite: 2026-01-22]
    if (_uid.isEmpty) {
      print("RUD: [경고] UID가 비어있어 스트림을 중단합니다.");
      // 빈 리스트를 담은 스트림을 반환하여 에러를 방지합니다. [cite: 2026-01-22]
      return Stream.value([]);
    }
    print("RUD: 자주 듣는 곡 실시간 모니터링 시작");

    return _firestore
        .collection('users')
        .doc(_uid)
        .snapshots() // ✅ snapshots()가 Stream을 생성합니다. [cite: 2026-01-22]
        .map((snapshot) {
          if (!snapshot.exists) {
            print("RUD: 데이터 없음 - 빈 리스트 반환");
            return [];
          }

          final data = snapshot.data()!;
          final account = AccountData.fromMap(data);

          print(
            "RUD: 자주 듣는 곡 실시간 업데이트 완료 (${account.frequentlyListenedVideos.length}개)",
          );
          return account.frequentlyListenedVideos;
        });
  }

  @override
  Future<int> getTodayCompletedCount() async {
    // 1. UID 체크 (로그인 안 되어 있으면 0)
    if (_uid.isEmpty) return 0;

    // 2. 오늘 00:00:00 계산
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);

    try {
      // 3. Firestore 쿼리 (snapshots 대신 get 사용)
      final snapshot = await _firestore
          .collection('users')
          .doc(_uid)
          .collection('study_history')
          .where(
            'studiedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfToday),
          )
          .get(); // 👈 여기서 한 번만 딱 가져옵니다.

      print("RUD: [Firebase] 오늘 학습 기록 조회 완료 (${snapshot.size}개)");

      // 4. 개수 반환
      return snapshot.size; // docs.length와 동일하지만 .size가 더 효율적입니다.
    } catch (e) {
      print("RUD: 학습 기록 조회 실패 - $e");
      return 0;
    }
  }

  @override
  Future<bool> isVideoCompletedToday(String youtubeVideoId) async {
    final startOfToday = DateTime.now().copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
    );
    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('study_history')
        .where('youtubeVideoId', isEqualTo: youtubeVideoId)
        .where(
          'studiedAt',
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfToday),
        )
        .get();
    return snapshot.docs.isNotEmpty;
  }

  @override
  Future<List<VideoInfo>> getFavoriteVideos() async {
    final account = await getAccount(_uid);
    return account?.favoriteYoutubeVideos ?? [];
  }

  @override
  Stream<List<StudiedVideoUI>> getStudiedVideosUI() {
    if (_uid.isEmpty) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(_uid)
        .collection('study_history')
        .orderBy('studiedAt', descending: true)
        .snapshots() // 실시간 감시 [cite: 2026-01-22]
        .asyncMap((snap) async {
          final account = await getAccount(_uid);
          final favIds =
              account?.favoriteYoutubeVideos
                  .map((v) => v.youtubeVideoId)
                  .toSet() ??
              {};

          List<StudiedVideoUI> uiList = [];
          for (var doc in snap.docs) {
            final d = doc.data();
            final vDoc = await _firestore
                .collection('global_videos')
                .doc(d['youtubeVideoId'])
                .get();
            if (vDoc.exists) {
              uiList.add(
                StudiedVideoUI(
                  recordId: d['recordId'],
                  studiedAt: (d['studiedAt'] as Timestamp).toDate(),
                  video: VideoInfo.fromMap(vDoc.data()!),
                  isFavorite: favIds.contains(d['youtubeVideoId']),
                ),
              );
            }
          }
          return uiList;
        });
  }

  @override
  Future<VideoInfo> getVideoFromYoutube(YoutubeVideo video) async {
    final doc = await _firestore
        .collection('global_videos')
        .doc(video.videoId)
        .get();
    if (doc.exists) return VideoInfo.fromMap(doc.data()!);
    final gv = GlobalVideoInfo(
      youtubeVideoId: video.videoId,
      title: video.title,
      artist: video.artist,
      thumbnailUrl: video.thumbnailUrl,
    );
    await saveGlobalVideo(gv);
    return VideoInfo.fromMap(gv.toMap());
  }

  @override
  Future<List<Lyric>> getLyricsForVideo(String id) async {
    final snap = await _firestore
        .collection('global_videos')
        .doc(id)
        .collection('lyrics')
        .orderBy('order', descending: false)
        .get();
    return snap.docs.map((doc) {
      final data = doc
          .data(); // ✅ Map으로 받아야 필드 부재 시 에러가 안 납니다. [cite: 2026-01-22]
      return Lyric.fromDb(
        content: data['content'] ?? '',
        translation: data['translation'] ?? '',
        notes: data['notes'] ?? '',
        startTimeMs: data['startTimeMs'],
      );
    }).toList();
  }

  @override
  Future<bool> getFavoriteStatus(String videoId) async {
    if (_uid.isEmpty) return false;

    // favoriteVideos 배열 내부의 youtubeVideoId를 검사하여 상태 반환
    final doc = await _firestore.collection('users').doc(_uid).get();
    if (!doc.exists) return false;

    final List<dynamic> favorites = doc.data()?['favoriteVideos'] ?? [];
    return favorites.any((v) => v['youtubeVideoId'] == videoId);
  }

  @override
  Future<GlobalVideoInfo?> getGlobalVideo(String youtubeVideoId) async {
    // FirebaseAuth가 아닌 FirebaseFirestore 인스턴스를 사용해야 합니다.
    final doc = await _firestore
        .collection('global_videos')
        .doc(youtubeVideoId)
        .get();

    if (!doc.exists) return null;

    // 문서 데이터를 GlobalVideoInfo 모델로 변환하여 반환
    return GlobalVideoInfo.fromMap(doc.data()!);
  }
  // --- [ 2. Save / Insert 그룹 ] ---

  @override
  Future<void> saveAccount(User user, String? deviceId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // 공통 업데이트 필드
      Map<String, dynamic> updateData = {
        'uid': user.uid,
        'email': user.email ?? '',
        'displayName': user.displayName,
        'photoUrl': user.photoURL,
        'lastLogin': FieldValue.serverTimestamp(),
        'lastDeviceId': deviceId,
      };

      if (userDoc.exists) {
        final data = userDoc.data()!;
        final lastActionTimestamp = data['lastActionDate'] as Timestamp?;

        if (lastActionTimestamp != null) {
          final lastDate = lastActionTimestamp.toDate();
          final lastDay = DateTime(lastDate.year, lastDate.month, lastDate.day);

          // ✅ [기존 유저] 날짜가 바뀌었으면 카운트를 1로 리셋 [cite: 2026-01-22]
          if (today.isAfter(lastDay)) {
            updateData['dailyAiCount'] = 1;
            updateData['dailyLyricCount'] = 1;
            updateData['lastActionDate'] = FieldValue.serverTimestamp();
            print("RUD: 날짜 변경 감지 - 일일 카운트 1로 초기화");
          }
          // 같은 날짜라면 아무것도 건드리지 않음 (기존 카운트 유지)
        }
      } else {
        // ✅ [신규 유저] 최초 생성 시 카운트를 1로 시작 [cite: 2026-01-22]
        updateData['dailyAiCount'] = 1;
        updateData['dailyLyricCount'] = 1;
        updateData['lastActionDate'] = FieldValue.serverTimestamp();
        print("RUD: 신규 계정 생성 - 카운트 1부터 시작");
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(updateData, SetOptions(merge: true));
      print("RUD: 로그인 및 일일 제한 동기화 완료");
    } catch (e) {
      print("RUD: saveAccount 실패 - $e");
    }
  }

  @override
  Future<void> saveFrequentlyVideo(VideoInfo video) async {
    await _firestore.collection('users').doc(_uid).update({
      'frequentlyVideos': FieldValue.arrayUnion([video.toMap()]),
    });
    print("RUD: 자주 듣는 곡 추가 완료");
  }

  @override
  Future<void> saveGlobalVideo(GlobalVideoInfo video) async {
    await _firestore
        .collection('global_videos')
        .doc(video.youtubeVideoId)
        .set(video.toMap(), SetOptions(merge: true));
    print("RUD: 글로벌 영상 정보 저장 완료");
  }

  @override
  Future<void> saveStudyRecord(String youtubeVideoId) async {
    final int recordId = DateTime.now().millisecondsSinceEpoch;
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('study_history')
        .doc(recordId.toString())
        .set({
          'recordId': recordId,
          'youtubeVideoId': youtubeVideoId,
          'studiedAt': FieldValue.serverTimestamp(),
        });
    print("RUD: 학습 완료 기록 저장 완료");
  }

  @override
  Future<void> insertLyricsData(String id, List<Lyric> lyrics) async {
    final batch = _firestore.batch();
    final col = _firestore
        .collection('global_videos')
        .doc(id)
        .collection('lyrics');
    for (int i = 0; i < lyrics.length; i++) {
      final dbLyric = GlobalLyricsData(
        youtubeVideoId: id,
        order: i,
        content: lyrics[i].rubyText.map((e) => e.text).join(),
        translation: lyrics[i].translation,
        notes: lyrics[i].notes.join('\n'),
        startTimeMs: lyrics[i].startTime?.inMilliseconds,
      );
      batch.set(col.doc(i.toString().padLeft(3, '0')), dbLyric.toMap());
    }
    await batch.commit();
    await updateIsLyrics(id, true);
    print("RUD: 가사 삽입 완료");
  }

  // --- [ 3. Update 그룹 ] ---

  @override
  Future<void> updateFavoriteStatus(VideoInfo video, bool status) async {
    final ref = _firestore.collection('users').doc(_uid);
    await ref.update({
      'favoriteVideos': status
          ? FieldValue.arrayUnion([video.toMap()])
          : FieldValue.arrayRemove([video.toMap()]),
    });
    print("RUD: 즐겨찾기 상태 변경 완료 ($status)");
  }

  @override
  Future<void> updateAnalyzedLyrics(String id, List<Lyric> lyrics) =>
      updateLyricsData(id, lyrics);

  @override
  Future<void> updateLyricsData(String id, List<Lyric> lyrics) async {
    final batch = _firestore.batch();
    final col = _firestore
        .collection('global_videos')
        .doc(id)
        .collection('lyrics');

    // [Step 1] 기존에 저장된 가사들을 가져옵니다.
    // 이유: 가사가 줄어들었을 때(예: 70줄 -> 60줄), 남은 찌꺼기(60~69번)를 지우기 위함
    final snapshot = await col.get();

    // [Step 2] 새로운 가사의 길이보다 인덱스가 크거나 같은 기존 문서는 삭제 큐에 담습니다.
    for (var doc in snapshot.docs) {
      // 문서 ID는 '000', '001' 형태이므로 int로 변환
      final int? docIndex = int.tryParse(doc.id);

      // 파싱에 성공했고, 현재 가사 길이보다 인덱스가 크다면(즉, 삭제되어야 할 뒷부분이라면)
      if (docIndex != null && docIndex >= lyrics.length) {
        batch.delete(doc.reference);
      }
    }

    // [Step 3] 새로운 가사 데이터를 덮어씁니다 (Insert & Update)
    for (int i = 0; i < lyrics.length; i++) {
      final l = lyrics[i];
      final ruby = l.rubyText
          .map((e) => e.ruby != null ? "${e.text}:${e.ruby}" : e.text)
          .join('|');

      final dbLyric = GlobalLyricsData(
        youtubeVideoId: id,
        order: i,
        content: ruby,
        translation: l.translation,
        notes: l.notes.join('\n'),
        startTimeMs: l.startTime?.inMilliseconds,
      );

      // doc 이름은 000, 001, ... 순서로 지정
      batch.set(
        col.doc(i.toString().padLeft(3, '0')),
        dbLyric.toMap(),
        SetOptions(merge: true),
      );
    }

    // [Step 4] 삭제와 생성을 한 번에 실행 (Atomic Operation)
    await batch.commit();

    await updateIsAnalyzed(id, true);
    print("RUD: 가사 데이터 업데이트 완료 (불필요한 데이터 삭제 포함)");
  }

  @override
  Future<void> updateIsAnalyzed(String id, bool status) async =>
      await _firestore.collection('global_videos').doc(id).update({
        'isAnalyzed': status,
      });
  @override
  Future<void> updateIsLyrics(String id, bool status) async => await _firestore
      .collection('global_videos')
      .doc(id)
      .update({'hasLyrics': status});

  @override
  Future<void> updateSearchedInfo({
    required String youtubeVideoId,
    required String searchedArtist,
    required String searchedTitle,
  }) async {
    await _firestore.collection('global_videos').doc(youtubeVideoId).update({
      'searchedArtist': searchedArtist,
      'searchedTitle': searchedTitle,
    });
    print("RUD: 검색 마스터 정보 업데이트 완료");
  }

  @override
  Future<void> updateDailyCount(String fieldName) async {
    try {
      // fieldName: 'dailyAiCount' 또는 'dailyLyricCount'
      await _firestore.collection('users').doc(_uid).update({
        fieldName: FieldValue.increment(1),
        'lastActionDate':
            FieldValue.serverTimestamp(), // 작업 시점에 날짜 갱신 [cite: 2026-01-22]
      });
      print("RUD: $fieldName 카운트 증가 완료");
    } catch (e) {
      print("RUD: 카운트 업데이트 실패 - $e");
    }
  }
  // --- [ 4. Delete 그룹 ] ---

  @override
  Future<void> deleteStudiedRecord(int recordId) async {
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('study_history')
        .doc(recordId.toString())
        .delete();
    print("RUD: 학습 기록 삭제 완료");
  }

  // /// Insert와 Update가 공유하는 핵심 로직
  // Future<void> _saveLyricsCommon(
  //   String id,
  //   List<Lyric> lyrics, {
  //   required bool isUpdate,
  // }) async {
  //   final batch = _firestore.batch();
  //   final col = _firestore
  //       .collection('global_videos')
  //       .doc(id)
  //       .collection('lyrics');

  //   // [Step 1] "찌꺼기 데이터" 삭제 (스마트 쿼리)
  //   // 예: 새 가사가 60줄이면, ID가 '060' 이상인 녀석들(기존 60~100번)을 찾아냅니다.
  //   final deleteStartId = lyrics.length.toString().padLeft(3, '0');

  //   final snapshot = await col
  //       .where(FieldPath.documentId, isGreaterThanOrEqualTo: deleteStartId)
  //       .get();

  //   for (var doc in snapshot.docs) {
  //     batch.delete(doc.reference);
  //   }

  //   // [Step 2] 새로운 가사 저장 (Upsert)
  //   for (int i = 0; i < lyrics.length; i++) {
  //     final l = lyrics[i];
  //     final ruby = l.rubyText
  //         .map((e) => e.ruby != null ? "${e.text}:${e.ruby}" : e.text)
  //         .join('|');

  //     final dbLyric = GlobalLyricsData(
  //       youtubeVideoId: id,
  //       order: i,
  //       content: ruby,
  //       translation: l.translation,
  //       notes: l.notes.join('\n'),
  //       startTimeMs: l.startTime?.inMilliseconds,
  //     );

  //     // docId: 000, 001, 002 ...
  //     batch.set(
  //       col.doc(i.toString().padLeft(3, '0')),
  //       dbLyric.toMap(),
  //       SetOptions(merge: true),
  //     );
  //   }

  //   // [Step 3] 상태 플래그 업데이트 (Batch에 포함시키지 않고 별도 실행해도 무방하지만 안전하게)
  //   // * Batch에 넣으려면 global_videos 문서 참조가 필요하므로,
  //   //   여기서는 편의상 기존처럼 별도 update 호출을 유지하거나 아래처럼 수행합니다.
  //   await batch.commit();

  //   // 메타데이터 상태 갱신
  //   if (isUpdate) {
  //     await updateIsAnalyzed(id, true);
  //   } else {
  //     await updateIsLyrics(id, true);
  //   }
  // }
}
