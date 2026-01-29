import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:japan_study/Models/VideoInfo.dart';

class AccountData {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final DateTime lastLogin;
  final String? lastDeviceId;

  // ✅ 추가된 속성들
  final List<VideoInfo>
  frequentlyListenedVideos; // 최대 27개 제한 [cite: 2026-01-22]
  final List<VideoInfo> favoriteYoutubeVideos; //즐겨찾기한 노래 리스트
  final int dailyAiCount; // 일일 AI 해석 횟수 (최대 3회) [cite: 2026-01-22]
  final int dailyLyricCount; // 일일 가사 가져오기 횟수 (최대 3회) [cite: 2026-01-22]
  final DateTime? lastActionDate; // 일일 제한 초기화를 위한 마지막 활동 날짜 [cite: 2026-01-22]

  AccountData({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.frequentlyListenedVideos = const [],
    this.favoriteYoutubeVideos = const [], // 초기값
    //기존 로그인시 바뀔정보
    required this.lastLogin,
    this.lastDeviceId,
    this.dailyAiCount = 0,
    this.dailyLyricCount = 0,
    this.lastActionDate,
  });

  factory AccountData.fromMap(Map<String, dynamic> map) => AccountData(
    uid: map['uid'] ?? '',
    email: map['email'] ?? '',
    displayName: map['displayName'],
    photoUrl: map['photoUrl'],
    lastLogin: (map['lastLogin'] as Timestamp).toDate(),
    lastDeviceId: map['lastDeviceId'],
    // Firestore List 타입을 Dart List<String>으로 변환
    frequentlyListenedVideos: (map['frequentlyVideos'] as List? ?? [])
        .map((v) => VideoInfo.fromMap(v))
        .toList(),
    favoriteYoutubeVideos: (map['favoriteVideos'] as List? ?? [])
        .map((v) => VideoInfo.fromMap(v))
        .toList(),
    dailyAiCount: map['dailyAiCount'] ?? 0,
    dailyLyricCount: map['dailyLyricCount'] ?? 0,
    lastActionDate: (map['lastActionDate'] as Timestamp?)?.toDate(),
  );

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'email': email,
    'displayName': displayName,
    'photoUrl': photoUrl,
    'lastLogin': Timestamp.fromDate(lastLogin),
    'lastDeviceId': lastDeviceId,
    'frequentlyVideos': frequentlyListenedVideos,
    'favoriteVideos': favoriteYoutubeVideos,
    'dailyAiCount': dailyAiCount,
    'dailyLyricCount': dailyLyricCount,
    'lastActionDate': lastActionDate != null
        ? Timestamp.fromDate(lastActionDate!)
        : null,
  };
}
