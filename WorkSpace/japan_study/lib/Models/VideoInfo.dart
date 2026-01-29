// lib/Models/VideoInfo.dart
class VideoInfo {
  final String youtubeVideoId;
  final String title;
  final String artist;
  final String thumbnailUrl;

  VideoInfo({
    required this.youtubeVideoId,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
  });

  factory VideoInfo.fromMap(Map<String, dynamic> map) => VideoInfo(
    youtubeVideoId: map['youtubeVideoId'] ?? '',
    title: map['title'] ?? '',
    artist: map['artist'] ?? '',
    thumbnailUrl: map['thumbnailUrl'] ?? '',
  );

  Map<String, dynamic> toMap() => {
    'youtubeVideoId': youtubeVideoId,
    'title': title,
    'artist': artist,
    'thumbnailUrl': thumbnailUrl,
  };
}
