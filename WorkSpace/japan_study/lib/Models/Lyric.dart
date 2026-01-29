// lib/Models/Global_Data/GlobalVideoInfo.dart (또는 Lyric 클래스 파일)
import 'package:ruby_text/ruby_text.dart';

class Lyric {
  final List<RubyTextData> rubyText;
  final String translation;
  final List<String> notes;
  final Duration? startTime;

  Lyric({
    required this.rubyText,
    required this.translation,
    this.notes = const [],
    this.startTime,
  });

  factory Lyric.fromDb({
    required String content,
    required String translation,
    required String notes,
    int? startTimeMs,
  }) {
    return Lyric(
      rubyText: _parseRawToRuby(content),
      translation: translation,
      notes: notes.isEmpty ? [] : notes.split('\n'),
      startTime: startTimeMs != null
          ? Duration(milliseconds: startTimeMs)
          : null,
    );
  }

  static List<RubyTextData> _parseRawToRuby(String text) {
    if (!text.contains('|') && !text.contains(':')) return [RubyTextData(text)];
    return text.split('|').map((segment) {
      if (segment.contains(':')) {
        final parts = segment.split(':');
        return RubyTextData(parts[0], ruby: parts[1]);
      }
      return RubyTextData(segment);
    }).toList();
  }
}
