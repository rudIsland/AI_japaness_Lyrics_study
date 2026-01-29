import 'dart:convert';
import 'package:http/http.dart' as http;

class LrcLibService {
  Future<String?> fetchSyncedLyrics(String artist, String title) async {
    try {
      final url = Uri.parse(
        "https://lrclib.net/api/get?artist=$artist&track=$title",
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("RUD: LrcLib 가사 수집 성공");
        return data['syncedLyrics'] as String?;
      }
      return null;
    } catch (e) {
      print("RUD: LrcLibService 에러 - $e");
      return null;
    }
  }
}
