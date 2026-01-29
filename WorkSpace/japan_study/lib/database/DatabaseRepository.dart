// lib/database/DatabaseRepository.dart
import 'package:japan_study/Models/VideoInfo.dart';
import 'package:japan_study/Models/Lyric.dart';
import 'package:japan_study/database/Account_Data/AccountData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:japan_study/Models/Display/StudiedVideoUI.dart';
import 'package:japan_study/database/Global_Data/GlobalVideoInfo.dart';

import 'package:japan_study/Service/Youtube/YoutubeSearcher.dart';

abstract class DatabaseRepository {
  /// ⚙️ 초기화
  Future<void> saveInitialize();

  /// 👤 [Group: Get] 조회
  Future<AccountData?> getAccount(String uid);
  Stream<List<VideoInfo>> getFrequentlyVideos();
  Future<int> getTodayCompletedCount();
  Future<bool> isVideoCompletedToday(String youtubeVideoId);
  Future<List<VideoInfo>> getFavoriteVideos();
  Stream<List<StudiedVideoUI>> getStudiedVideosUI();
  Future<VideoInfo> getVideoFromYoutube(YoutubeVideo video);
  Future<List<Lyric>> getLyricsForVideo(String youtubeVideoId);
  Future<GlobalVideoInfo?> getGlobalVideo(String youtubeVideoId);

  /// 📥 [Group: Save/Insert] 생성 및 저장
  Future<void> saveAccount(User user, String? deviceId);
  Future<void> saveFrequentlyVideo(VideoInfo video);
  Future<void> saveGlobalVideo(GlobalVideoInfo video);
  Future<void> saveStudyRecord(String youtubeVideoId);
  Future<void> insertLyricsData(String youtubeVideoId, List<Lyric> lyrics);
  Future<bool> getFavoriteStatus(String videoId);

  /// 🛠️ [Group: Update] 수정
  Future<void> updateFavoriteStatus(VideoInfo video, bool status);
  Future<void> updateAnalyzedLyrics(String youtubeVideoId, List<Lyric> lyrics);
  Future<void> updateLyricsData(String youtubeVideoId, List<Lyric> lyrics);
  Future<void> updateIsAnalyzed(String youtubeVideoId, bool status);
  Future<void> updateIsLyrics(String youtubeVideoId, bool status);
  Future<void> updateSearchedInfo({
    required String youtubeVideoId,
    required String searchedArtist,
    required String searchedTitle,
  });

  /// 🛠️ [Update] 특정 필드의 카운트를 1 올리고 날짜를 오늘로 기록
  Future<void> updateDailyCount(String fieldName);

  /// 🗑️ [Group: Delete] 삭제
  Future<void> deleteStudiedRecord(int recordId);
}
