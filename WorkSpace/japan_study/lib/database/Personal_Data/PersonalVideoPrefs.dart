// lib/database/Personal_Data/PersonalVideoPrefs.dart
class PersonalVideoPrefs {
  final String uid; // FK: AccountData 참조 [cite: 2026-01-22]
  final String youtubeVideoId; // FK: GlobalVideoInfo 참조 [cite: 2026-01-22]
  final bool isFavorite;
  final String? searchedTitle;
  final String? searchedArtist;

  PersonalVideoPrefs({
    required this.uid,
    required this.youtubeVideoId,
    this.isFavorite = false,
    this.searchedTitle,
    this.searchedArtist,
  });

  factory PersonalVideoPrefs.fromMap(Map<String, dynamic> map) =>
      PersonalVideoPrefs(
        uid: map['uid'] ?? '',
        youtubeVideoId: map['youtubeVideoId'] ?? '',
        isFavorite: map['isFavorite'] ?? false,
        searchedTitle: map['searchedTitle'],
        searchedArtist: map['searchedArtist'],
      );

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'youtubeVideoId': youtubeVideoId,
    'isFavorite': isFavorite,
    'searchedTitle': searchedTitle,
    'searchedArtist': searchedArtist,
  };
}
