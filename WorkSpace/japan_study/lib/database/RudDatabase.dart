import 'package:firebase_auth/firebase_auth.dart';
import 'package:japan_study/database/DatabaseRepository.dart';
import 'package:japan_study/database/DriftDB.dart';
import 'package:japan_study/database/FirebaseDB.dart';
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/Models/Lyric.dart';
import 'package:japan_study/database/Account_Data/AccountData.dart';
import 'package:japan_study/Models/Display/StudiedVideoUI.dart';
import 'package:japan_study/database/Global_Data/GlobalVideoInfo.dart';

import 'package:japan_study/Service/Youtube/YoutubeSearcher.dart';

class RudDatabase {
  static final RudDatabase _instance = RudDatabase._internal();
  factory RudDatabase() => _instance;
  final FirebaseDB _fb;
  final FirebaseAuth _fbAuth = FirebaseAuth.instance;

  DriftDB _drift;

  RudDatabase._internal() : _fb = FirebaseDB(), _drift = DriftDB();

  bool get isLoggedIn => _fbAuth.currentUser != null;
  DatabaseRepository get _db => currentUid.isEmpty ? _drift : _fb;

  String get currentUid => _fbAuth.currentUser?.uid ?? '';

  bool _checkPermission() {
    if (!isLoggedIn) {
      print("RUD: [권한 없음] 게스트는 AI/가사 데이터를 수정할 수 없습니다.");
      return false;
    }
    return true;
  }

  // Group: Get
  Future<AccountData?> getAccount(String uid) => _db.getAccount(uid);
  Stream<List<VideoInfo>> getFrequentlyVideos() => _db.getFrequentlyVideos();
  Future<int> getTodayCompletedCount() => _db.getTodayCompletedCount();
  Future<bool> isVideoCompletedToday(String id) =>
      _db.isVideoCompletedToday(id);
  Future<List<VideoInfo>> getFavoriteVideos() => _db.getFavoriteVideos();
  Stream<List<StudiedVideoUI>> getStudiedVideosUI() => _db.getStudiedVideosUI();
  Future<VideoInfo> getVideoFromYoutube(YoutubeVideo video) =>
      _db.getVideoFromYoutube(video);
  Future<List<Lyric>> getLyricsForVideo(String id) => _db.getLyricsForVideo(id);
  Future<bool> getFavoriteStatus(String videoId) =>
      _db.getFavoriteStatus(videoId);
  Future<GlobalVideoInfo?> getGlobalVideo(String youtubeVideoId) =>
      _db.getGlobalVideo(youtubeVideoId);

  // Group: Save
  Future<void> saveInitialize() => _db.saveInitialize();
  Future<void> saveAccount(User user, String? id) => _db.saveAccount(user, id);
  Future<void> saveFrequentlyVideo(VideoInfo v) => _db.saveFrequentlyVideo(v);
  Future<void> saveGlobalVideo(GlobalVideoInfo v) => _db.saveGlobalVideo(v);
  Future<void> saveStudyRecord(String id) => _db.saveStudyRecord(id);
  Future<void> insertLyricsData(String id, List<Lyric> l) async {
    if (!_checkPermission()) return;
    await _db.insertLyricsData(id, l);
  }

  // Group: Update
  Future<void> updateFavoriteStatus(VideoInfo v, bool s) =>
      _db.updateFavoriteStatus(v, s);

  Future<void> updateAnalyzedLyrics(String id, List<Lyric> l) async {
    if (!_checkPermission()) return;
    await _db.updateAnalyzedLyrics(id, l);
  }

  //  [Blocked] 가사 데이터 수정
  Future<void> updateLyricsData(String id, List<Lyric> l) async {
    if (!_checkPermission()) return;
    await _db.updateLyricsData(id, l);
  }

  //  [Blocked] 분석 상태 변경
  Future<void> updateIsAnalyzed(String id, bool s) async {
    if (!_checkPermission()) return;
    await _db.updateIsAnalyzed(id, s);
  }

  //  [Blocked] 가사 존재 여부 변경
  Future<void> updateIsLyrics(String id, bool s) async {
    if (!_checkPermission()) return;
    await _db.updateIsLyrics(id, s);
  }

  Future<void> updateSearchedInfo({
    required String youtubeVideoId,
    required String searchedArtist,
    required String searchedTitle,
  }) => _db.updateSearchedInfo(
    youtubeVideoId: youtubeVideoId,
    searchedArtist: searchedArtist,
    searchedTitle: searchedTitle,
  );
  Future<void> updateDailyCount(String fieldName) async {
    if (!_checkPermission()) return;
    await _db.updateDailyCount(fieldName);
  }

  // Group: Delete
  Future<void> deleteStudiedRecord(int id) => _db.deleteStudiedRecord(id);
}
