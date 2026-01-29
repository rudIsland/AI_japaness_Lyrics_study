import 'package:drift/drift.dart';

// ✅ 로컬 사용자 정보 테이블 정의 [cite: 2026-01-22]
class LocalUsers extends Table {
  TextColumn get uid => text()(); // 고유 ID
  TextColumn get email => text().nullable()(); // 이메일
  TextColumn get displayName => text().nullable()(); // 이름
  TextColumn get photoUrl => text().nullable()(); // 프로필 사진
  DateTimeColumn get lastLogin => dateTime().nullable()(); // 마지막 로그인 날짜

  @override
  Set<Column> get primaryKey => {uid}; // UID를 기본키로 지정 [cite: 2026-01-22]
}
