// lib/database/Global_Data/GlobalVideoInfo.dart
class GlobalVideoInfo {
  final String youtubeVideoId;
  final String title;
  final String artist;
  final String thumbnailUrl;

  final String? searchedTitle;
  final String? searchedArtist;

  final bool hasLyrics; // 가사 데이터 존재 여부
  final bool isAnalyzed; // AI 분석 완료 여부

  GlobalVideoInfo({
    required this.youtubeVideoId,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
    this.searchedTitle,
    this.searchedArtist,
    this.hasLyrics = false,
    this.isAnalyzed = false,
  });

  factory GlobalVideoInfo.fromMap(Map<String, dynamic> map) => GlobalVideoInfo(
    youtubeVideoId: map['youtubeVideoId'] ?? '',
    title: map['title'] ?? '',
    artist: map['artist'] ?? '',
    thumbnailUrl: map['thumbnailUrl'] ?? '',
    searchedTitle: map['searchedTitle'], // 추가
    searchedArtist: map['searchedArtist'], // 추가
    hasLyrics: map['hasLyrics'] ?? false,
    isAnalyzed: map['isAnalyzed'] ?? false,
  );

  Map<String, dynamic> toMap() => {
    'youtubeVideoId': youtubeVideoId,
    'title': title,
    'artist': artist,
    'thumbnailUrl': thumbnailUrl,
    'searchedTitle': searchedTitle,
    'searchedArtist': searchedArtist,
    'hasLyrics': hasLyrics,
    'isAnalyzed': isAnalyzed,
  };
}
