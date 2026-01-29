import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:japan_study/config/secrets.dart';

class YoutubeVideo {
  final String videoId;
  final String title;
  final String artist;
  final String thumbnailUrl;

  YoutubeVideo({
    required this.videoId,
    required this.title,
    required this.artist,
    required this.thumbnailUrl,
  });

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
      videoId: json['id']['videoId'] ?? '',
      title: json['snippet']['title'] ?? '',
      artist: json['snippet']['channelTitle'] ?? '',
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'] ?? '',
    );
  }
}

class YoutubeSearcher {
  final String _searchUrl = "https://www.googleapis.com/youtube/v3/search";
  final String _recommendUrl =
      "https://suggestqueries.google.com/complete/search?client=firefox&ds=yt&q=";

  Future<List<String>> getRecommendTexts(String query) async {
    if (query.isEmpty) return [];

    try {
      final response = await http.get(Uri.parse("$_recommendUrl$query"));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return List<String>.from(data[1]);
      }
    } catch (error) {
      print("RUD: 추천어 로드 실패: $error");
    }
    return [];
  }

  // 노래(Music 카테고리)만 나오도록 필터링된 검색
  Future<List<YoutubeVideo>> searchVideos(String query) async {
    // print("RUD: 유튜브 음악 검색 시작 - 쿼리: $query");

    // // videoCategoryId=10 필터를 추가하여 음악 섹션의 데이터만 가져옵니다.
    // final uri = Uri.parse(
    //   "$_searchUrl?part=snippet"
    //   "&q=${Uri.encodeComponent(query)}"
    //   "&type=video"
    //   "&videoCategoryId=10"
    //   "&key=${Secrets.youtubeApiKey}"
    //   "&maxResults=10"
    //   "&chart=mostPopular",
    // );

    // final response = await http.get(uri);

    print("RUD: 유튜브 음악 검색 시작 - 쿼리: $query");

    final uri = Uri.parse(
      "$_searchUrl?part=snippet"
      "&q=${Uri.encodeComponent(query)}"
      "&type=video" // 1. 채널(#channel)과 플레이리스트를 결과에서 완전히 제외합니다. [cite: 2026-01-22]
      "&videoCategoryId=10" // 2. 음악 카테고리로 필터링합니다. [cite: 2026-01-22]
      "&videoEmbeddable=true" // 3. 외부 재생이 가능한 영상만 가져와 '채널 전용' 콘텐츠를 필터링합니다. [cite: 2026-01-22]
      "&videoSyndicated=true" // 4. 외부 매체에서 재생 가능한 공식적인 영상 위주로 검색합니다. [cite: 2026-01-22]
      "&key=${Secrets.youtubeApiKey}"
      "&maxResults=10",
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'];

      print("RUD: 유튜브 음악 검색 성공 - 수신: ${items.length}건");
      return items.map((item) => YoutubeVideo.fromJson(item)).toList();
    } else {
      print("RUD: 유튜브 API 에러 - 코드: ${response.statusCode}");
      throw Exception("유튜브 API 통신 에러");
    }
  }
}
