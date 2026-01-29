// lib/Service/Lyric/LyricAnalysisService.dart
import 'package:japan_study/Service/AI/GeminiAIService.dart';
import 'package:japan_study/Service/AI/IAIService.dart';
import 'package:japan_study/database/RudDatabase.dart';
import 'package:japan_study/Models/Lyric.dart';
import 'package:ruby_text/ruby_text.dart';

class LyricAnalysisService {
  final IAIService _geminiService = GeminiAIService();

  /// ✅ UI 호출부 파라미터와 100% 일치하도록 수정
  Future<void> analyzeAndSaveFullLyrics({
    required String youtubeVideoId,
    required List<Lyric> lyrics, // ✅ LyricData 대신 Lyric 리스트 사용
    required RudDatabase database, // ✅ DriftDB 대신 RudDatabase 사용
  }) async {
    if (lyrics.isEmpty) return;

    // 1. 분석용 순수 텍스트 리스트 생성 (RubyTextData에서 원문만 추출)
    final List<String> lyricsTexts = lyrics.map((l) {
      return l.rubyText.map((e) => e.text).join();
    }).toList();

    // 1. 일일 AI 분석 횟수 체크 [cite: 2026-01-22]
    final account = await database.getAccount(database.currentUid);
    // ※ RudDatabase에 currentUid 게터가 있다고 가정하거나 FirebaseAuth에서 직접 가져옵니다.

    if (account != null && account.dailyAiCount > 3) {
      print("RUD: 일일 AI 분석 횟수 초과 (현재: ${account.dailyAiCount - 1}/3)");
      return;
    }

    // 일본어 포함 여부 확인 (언어 방향 판별)
    final bool isJapanese = RegExp(
      r'[\u3040-\u309F\u30A0-\u30FF]',
    ).hasMatch(lyricsTexts.first);
    final String targetLanguage = isJapanese ? "한국어" : "일본어";

    try {
      print("RUD: AI 해석 시작 ($targetLanguage 방향)");

      // 2. Gemini 호출
      final List<dynamic> analysisResults = await _geminiService
          .analyzeAllLyrics(lyricsTexts, targetLanguage);

      // 3. 분석 결과가 반영된 새로운 Lyric 리스트 생성
      final List<Lyric> analyzedLyrics = [];

      for (var result in analysisResults) {
        final int order = result['order'];
        if (order < lyrics.length) {
          final String rubyRaw = result['ruby'] ?? "";
          final String aiTranslation = result['translation'] ?? "";
          final String notes = result['notes'] ?? "";

          analyzedLyrics.add(
            Lyric(
              // AI가 준 후리가나 문자열을 다시 RubyTextData 리스트로 파싱 [cite: 2026-01-24]
              rubyText: _parseRubyString(rubyRaw),
              // 한국어 곡이면 AI 번역 대신 원문을, 일본어 곡이면 AI 번역을 사용 [cite: 2026-01-22]
              translation: isJapanese ? aiTranslation : lyricsTexts[order],
              notes: notes.isEmpty ? [] : notes.split('\n'),
              startTime: lyrics[order].startTime, // 기존 싱크 시간 유지
            ),
          );
        }
      }

      // 4. RudDatabase를 통해 일괄 업데이트 (이제 여기서 갈림길이 결정됨)
      await database.updateAnalyzedLyrics(youtubeVideoId, analyzedLyrics);

      // ✅ 5. 분석 성공 시 일일 카운트 증가 [cite: 2026-01-22]
      await database.updateDailyCount('dailyAiCount');

      print("RUD: AI 가사 업데이트 완료");
    } catch (error) {
      print("RUD: 가사 분석 중 에러 발생 - $error");
    }
  }

  // AI로부터 받은 "한자:요미가나" 형태를 RubyTextData로 변환
  List<RubyTextData> _parseRubyString(String raw) {
    return raw.split('|').map((segment) {
      if (segment.contains(':')) {
        var parts = segment.split(':');
        return RubyTextData(parts[0], ruby: parts[1]);
      }
      return RubyTextData(segment);
    }).toList();
  }
}
