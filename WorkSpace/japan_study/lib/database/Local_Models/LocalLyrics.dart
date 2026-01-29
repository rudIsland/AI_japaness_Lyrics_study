import 'package:drift/drift.dart';
import 'package:japan_study/database/Local_Models/LocalVideos.dart';

class LocalLyrics extends Table {
  IntColumn get id => integer().autoIncrement()();
  // LocalVideos 테이블의 youtubeVideoId를 참조 (외래키)
  TextColumn get youtubeVideoId =>
      text().references(LocalVideos, #youtubeVideoId)();
  IntColumn get order => integer()();
  TextColumn get content => text()();
  TextColumn get translation => text()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  IntColumn get startTimeMs => integer().nullable()();
}
