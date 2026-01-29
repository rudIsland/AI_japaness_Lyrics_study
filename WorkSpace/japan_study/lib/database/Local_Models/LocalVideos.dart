import 'package:drift/drift.dart';

// 로컬용 영상 마스터 정보 테이블
class LocalVideos extends Table {
  TextColumn get youtubeVideoId => text()(); // PK
  TextColumn get title => text()();
  TextColumn get artist => text()();
  TextColumn get thumbnailUrl => text()();

  // 선택적 필드
  BoolColumn get hasLyrics => boolean().withDefault(const Constant(false))();
  BoolColumn get isAnalyzed => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {youtubeVideoId};
}
