// lib/Service/Lyric/LyricFetchService.dart
import 'package:japan_study/Service/Lyric/NeteaseLyricsService.dart';
import 'package:japan_study/Service/Lyric/LrcLibService.dart';
import 'package:japan_study/Models/Lyric.dart';
import 'package:ruby_text/ruby_text.dart';

class LyricFetchService {
  final NeteaseLyricsService _neteaseService = NeteaseLyricsService();
  final LrcLibService _lrcLibService = LrcLibService();

  /// 가사를 불러와서 시간과 텍스트를 분리(가공)한 뒤 리스트로 반환합니다.
  Future<List<Lyric>?> fetchAndParseLyrics({
    required String youtubeVideoId,
    required String title,
    required String artist,
  }) async {
    try {
      String? rawLyrics; // API에서 가져온 날것의 가사

      // 1. 수집 로직 (기존과 동일)
      int? songId = await _neteaseService.searchSongId(artist, title);
      rawLyrics = (songId != null)
          ? await _neteaseService.fetchLyrics(songId)
          : null;
      if (rawLyrics == null)
        rawLyrics = await _lrcLibService.fetchSyncedLyrics(artist, title);
      if (rawLyrics == null || rawLyrics.isEmpty) return null;

      final List<Lyric> processedLyrics = [];
      final RegExp timeRegex = RegExp(r'\[(\d{2}):(\d{2})\.(\d{2,3})\]');
      // [ar:가수], [ti:제목] 등 가사가 아닌 메타데이터 필터링 정규식 [cite: 2026-01-22]
      final RegExp metadataRegex = RegExp(r'\[[a-z]{2}:.*\]');

      for (String line in rawLyrics.split('\n')) {
        String trimmedLine = line.trim();
        // 빈 줄이거나 가사가 아닌 메타데이터는 저장하지 않음 [cite: 2026-01-22]
        if (trimmedLine.isEmpty || metadataRegex.hasMatch(trimmedLine))
          continue;

        final match = timeRegex.firstMatch(trimmedLine);
        Duration? startTime;
        String content = trimmedLine;

        if (match != null) {
          startTime = Duration(
            minutes: int.parse(match.group(1)!),
            seconds: int.parse(match.group(2)!),
            milliseconds: int.parse(match.group(3)!),
          );
          content = trimmedLine.replaceFirst(timeRegex, '').trim();
        }

        if (content.isNotEmpty) {
          processedLyrics.add(
            Lyric(
              rubyText: [RubyTextData(content)],
              translation: "",
              startTime: startTime,
            ),
          );
        }
      }
      return processedLyrics;
    } catch (e) {
      print("RUD Error (LyricFetch): $e");
      return null;
    }
  }
}
