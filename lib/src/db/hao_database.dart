import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


part 'hao_database.g.dart';

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}

class Titles extends Table with AutoIncrementingPrimaryKey {
  TextColumn get title => text()();
  BoolColumn get isFavorite => boolean().nullable()();
  DateTimeColumn get chatDate => dateTime()();
}

class Conversations extends Table with AutoIncrementingPrimaryKey {
  IntColumn get titleId => integer().references(Titles, #id)();
  TextColumn get inputMessage => text()();
  TextColumn get prompt => text()();
  TextColumn get completion => text().nullable()();
  BoolColumn get isError => boolean().nullable()();
  DateTimeColumn get promptDate => dateTime()();
}

@DriftDatabase(tables: [Titles, Conversations])
class HaoDatabase extends _$HaoDatabase {
  HaoDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        // Make sure that foreign keys are enabled
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'hao_chat.db'));
    return NativeDatabase.createInBackground(file);
  });
}

final haoDatabase = HaoDatabase();