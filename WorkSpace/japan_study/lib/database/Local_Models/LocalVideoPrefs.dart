import 'package:drift/drift.dart';

class LocalVideoPrefs extends Table {
  TextColumn get uid => text()();
  TextColumn get youtubeVideoId => text()();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  TextColumn get searchedTitle => text().nullable()();
  TextColumn get searchedArtist => text().nullable()();

  @override
  Set<Column> get primaryKey => {uid, youtubeVideoId};
}
