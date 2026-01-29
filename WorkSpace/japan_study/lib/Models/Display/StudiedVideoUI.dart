import 'package:japan_study/Models/VideoInfo.dart';

class StudiedVideoUI {
  final VideoInfo video; // 공용 영상 정보
  final DateTime studiedAt; // 개인 공부 시간 (StudyRecord에서 가져옴)
  bool isFavorite; // 개인 즐겨찾기 여부 (AccountData에서 판별)
  final int? recordId; // 삭제 시 필요한 기록 고유 ID

  StudiedVideoUI({
    required this.video,
    required this.studiedAt,
    required this.isFavorite,
    this.recordId,
  });
}
