// import 'dart:convert';
// import 'package:flutter_gemma/flutter_gemma.dart';
// import 'package:flutter_gemma/core/message.dart'; // Message 클래스 필요
// import 'package:japan_study/Service/IAIService.dart';

// class GemmaAIService implements IAIService {
//   bool _isInitialized = false;

//   Future<void> _initEngine() async {
//     if (_isInitialized && FlutterGemma.hasActiveModel()) return;

//     // 1. 서비스 엔진 초기화
//     await FlutterGemma.initialize();

//     // 2. 모델 설치 및 활성화 (이 과정이 있어야 No active inference model 에러가 안 납니다)
//     // 이미 설치되어 있다면 내부적으로 건너뛰고 '활성화'만 수행합니다.
//     await FlutterGemma.installModel(modelType: ModelType.gemmaIt)
//         .fromAsset('assets/gemma_int4.task') // pubspec.yaml에 등록한 경로
//         .install();

//     _isInitialized = true;
//     print("RUD: Gemma 로컬 모델 활성화 완료");
//   }

//   @override
//   Future<List<dynamic>> analyzeAllLyrics(
//     List<String> lyrics,
//     String targetLanguage,
//   ) async {
//     if (lyrics.isEmpty) return [];
//     if (!_isInitialized) await _initEngine();

//     final promptText =
//         """
// 당신은 일본어 학습 도우미입니다. 가사를 분석하여 다음 JSON 형식으로만 답변하세요.
// 형식: [{"order": 숫자, "ruby": "한자:후리가나", "translation": "번역"}]
// 가사 내용: ${lyrics.join('\n')}
// """;

//     try {
//       final model = await FlutterGemma.getActiveModel();
//       final session = await model.createSession();

//       // ⚡️ 중요: getResponse() 호출 전 addQueryChunk로 메시지 추가
//       await session.addQueryChunk(Message(text: promptText));

//       // 매개변수 없이 호출
//       final response = await session.getResponse();

//       final jsonMatch = RegExp(r'\[[\s\S]*\]').firstMatch(response);
//       if (jsonMatch != null) {
//         return json.decode(jsonMatch.group(0)!) as List<dynamic>;
//       }
//     } catch (e) {
//       print("RUD: Gemma 분석 실패 - $e");
//     }
//     return [];
//   }
// }
