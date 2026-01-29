import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:japan_study/config/secrets.dart';
import 'package:japan_study/Service/AI/IAIService.dart';

class GeminiAIService implements IAIService {
  late final GenerativeModel _model;

  GeminiAIService() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: Secrets.geminiApiKey,
    );
  }

  Future<String> generateContent(String prompt) async {
    try {
      print("RUD: AI 배치 분석 요청됨");
      final response = await _model.generateContent([Content.text(prompt)]);
      return response.text ?? "";
    } catch (e) {
      print("RUD: Gemini API 호출 오류 - $e");
      return "";
    }
  }

  /// 가사 전체를 받아 지정된 언어로 번역을 수행합니다. [cite: 2026-01-18]
  @override
  Future<List<dynamic>> analyzeAllLyrics(
    List<String> lyrics,
    String targetLanguage,
  ) async {
    if (lyrics.isEmpty) return [];

    final prompt =
        """
일본어 노래 가사를 분석해서 $targetLanguage로 번역하고, 일본어 가사에는 후리가나를 붙여줘. [cite: 2026-01-18]

반드시 아래 규칙을 지켜:
1. 일본어 한자가 있는 경우 '한자:후리가나' 형태로 적고, 단어 사이는 '|'로 구분해. [cite: 2026-01-18]
2. 각 줄에 대해 한국어 번역(translation)을 포함해. [cite: 2026-01-18]
3. 'notes' 필드에는 해당 가사 줄의 학습 설명문을 포함해. [cite: 2026-01-22]
   - 주요 일본어 단어의 기본형과 한국어 뜻. [cite: 2026-01-22]
   - 핵심 문법 구조에 대한 짧은 해설. [cite: 2026-01-22]
   - 각 설명은 줄바꿈(\\n)으로 구분해서 하나의 문자열로 반환해. [cite: 2026-01-22]
4. 결과는 반드시 JSON 배열 형식으로만 출력해. [cite: 2026-01-18]

가사 데이터:
${lyrics.join('\n')}

반환 형식 예시:
[
  {
    "order": 0,
    "ruby": "君:きみ|와|手:て|를|繋:つ나|이다라",
    "translation": "너와 손을 잡으면",
    "notes": "君: 너\\n手: 손\\n繋ぐ: 잇다, 잡다"
  }
]
""";

    try {
      final rawText = await generateContent(prompt);
      final RegExp jsonRegExp = RegExp(r'\[[\s\S]*\]');
      final match = jsonRegExp.firstMatch(rawText);

      if (match != null) {
        return json.decode(match.group(0)!) as List<dynamic>;
      }
      return [];
    } catch (e) {
      print("RUD: 배치 분석 응답 파싱 오류 - $e");
      return [];
    }
  }
}
