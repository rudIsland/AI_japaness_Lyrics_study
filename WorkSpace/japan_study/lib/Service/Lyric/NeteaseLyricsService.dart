import 'dart:convert';
import 'package:http/http.dart' as http;

class NeteaseLyricsService {
  final String _searchUrl = "https://music.163.com/api/search/get";
  final String _lyricUrl = "https://music.163.com/api/song/lyric";

  Future<int?> searchSongId(String artist, String title) async {
    final query = "$artist $title";
    print("RUD: NetEase 검색 시작 - $query");

    try {
      final uri = Uri.parse(
        "$_searchUrl?s=${Uri.encodeComponent(query)}&type=1&limit=1",
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final songs = data['result']?['songs'];
        if (songs != null && songs.isNotEmpty) {
          return songs[0]['id'];
        }
      }
    } catch (e) {
      print("RUD: NetEase 검색 중 오류 - $e");
    }
    return null;
  }

  Future<String?> fetchLyrics(int songId) async {
    print("RUD: NetEase 가사 본문 요청 - ID: $songId");
    try {
      final uri = Uri.parse("$_lyricUrl?id=$songId&lv=1&kv=1&tv=-1");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String? rawLyrics = data['lrc']?['lyric'];

        if (rawLyrics != null && rawLyrics.isNotEmpty) {
          // RUD: 수신된 가사에서 작사/작곡 등의 정보를 제거하여 반환합니다.
          return _cleanLyrics(rawLyrics);
        }
      }
    } catch (e) {
      print("RUD: NetEase 가사 수신 중 오류 - $e");
    }
    return null;
  }

  // RUD: NetEase 특유의 메타 정보(작사, 작곡, 편곡 등)가 포함된 라인을 제거합니다.
  String _cleanLyrics(String lyrics) {
    final List<String> lines = lyrics.split('\n');

    // 필터링할 키워드 목록 (한글, 한자, 영어 대응)
    final List<String> noiseKeywords = [
      '作词',
      '作曲',
      '编曲',
      'Lyrics',
      'Composer',
      'Arranger',
      'Written by',
      'Produced by',
    ];

    final List<String> cleanedLines = lines.where((line) {
      // 1. 타임스탬프 뒤의 텍스트가 위 키워드를 포함하는지 확인
      String content = line;
      if (line.contains(']')) {
        content = line.split(']').last.trim();
      }

      // 2. 키워드가 포함된 줄이거나 빈 줄이면 제외
      if (content.isEmpty) return false;
      return !noiseKeywords.any((keyword) => content.contains(keyword));
    }).toList();

    return cleanedLines.join('\n');
  }
}
