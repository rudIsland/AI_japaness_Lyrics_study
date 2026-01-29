import 'package:drift/drift.dart';

// 1. 공부 기록 테이블 (PersonalStudyHistory 대응)
class LocalStudyHistory extends Table {
  // 단, 1:1 매칭을 위해 Text로 하셔도 무방합니다. 여기선 String으로 맞춥니다.)
  IntColumn get recordId => integer()();

  // FK: Device UID (Guest ID)
  TextColumn get uid => text()();

  // FK: Youtube Video ID
  TextColumn get youtubeVideoId => text()();

  // Firebase의 Timestamp -> Drift의 DateTime
  DateTimeColumn get studiedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {recordId}; // PK 설정
}
