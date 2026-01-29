class GlobalLyricsData {
  final String youtubeVideoId; // ✅ FK: GlobalVideoInfo를 참조 [cite: 2026-01-22]
  final int order;
  final String content; // 후리가나 포함 원문
  final String translation; // 번역
  final String notes; // AI 단어장 (줄바꿈 구분)
  final int? startTimeMs;

  GlobalLyricsData({
    required this.youtubeVideoId,
    required this.order,
    required this.content,
    required this.translation,
    this.notes = '',
    this.startTimeMs,
  });

  factory GlobalLyricsData.fromMap(Map<String, dynamic> map) =>
      GlobalLyricsData(
        youtubeVideoId: map['youtubeVideoId'] ?? '', // 추가 [cite: 2026-01-22]
        order: map['order'] ?? 0,
        content: map['content'] ?? '',
        translation: map['translation'] ?? '',
        notes: map['notes'] ?? '',
        startTimeMs: map['startTimeMs'],
      );

  Map<String, dynamic> toMap() => {
    'youtubeVideoId': youtubeVideoId, // 추가 [cite: 2026-01-22]
    'order': order,
    'content': content,
    'translation': translation,
    'notes': notes,
    'startTimeMs': startTimeMs,
  };
}
