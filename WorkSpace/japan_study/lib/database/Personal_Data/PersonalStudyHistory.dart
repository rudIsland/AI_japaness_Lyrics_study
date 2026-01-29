import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalStudyHistory {
  final Int recordId; // ✅ PK: 고유 기록 ID (타임스탬프 기반)
  final String uid; // FK: AccountData 참조
  final String youtubeVideoId; // FK: GlobalVideoInfo 참조
  final DateTime studiedAt;

  PersonalStudyHistory({
    required this.recordId,
    required this.uid,
    required this.youtubeVideoId,
    required this.studiedAt,
  });

  factory PersonalStudyHistory.fromMap(
    Map<String, dynamic> map, {
    String? docId,
  }) => PersonalStudyHistory(
    // 문서 ID를 recordId로 사용하거나 맵 안의 값을 사용
    recordId: docId ?? map['recordId'] ?? '',
    uid: map['uid'] ?? '',
    youtubeVideoId: map['youtubeVideoId'] ?? '',
    studiedAt: (map['studiedAt'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toMap() => {
    'recordId': recordId, // 맵에도 포함하여 데이터 정합성 유지
    'uid': uid,
    'youtubeVideoId': youtubeVideoId,
    'studiedAt': Timestamp.fromDate(studiedAt),
  };
}
