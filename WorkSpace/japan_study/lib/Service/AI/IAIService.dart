abstract class IAIService {
  Future<List<dynamic>> analyzeAllLyrics(
    List<String> lyrics,
    String targetLanguage,
  );
}
