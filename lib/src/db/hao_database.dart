import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;


part 'hao_database.g.dart';

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement()();
}

@Deprecated('Use Chats instead')
class ChatTitles extends Table with AutoIncrementingPrimaryKey {
  TextColumn get title => text()();
  BoolColumn get isFavorite => boolean().nullable()();
  DateTimeColumn get chatDate => dateTime()();
}

@Deprecated('Use Messages instead')
class Conversations extends Table with AutoIncrementingPrimaryKey {
  IntColumn get titleId => integer().references(ChatTitles, #id)();
  TextColumn get inputMessage => text()();
  TextColumn get prompt => text()();
  TextColumn get completion => text().nullable()();
  BoolColumn get isError => boolean().nullable()();
  DateTimeColumn get promptDate => dateTime()();
}

class Chats extends Table with AutoIncrementingPrimaryKey {
  TextColumn get title => text()();
  TextColumn get system => text()();
  BoolColumn get isFavorite => boolean()();
  DateTimeColumn get chatDateTime => dateTime()();
}

class Messages extends Table with AutoIncrementingPrimaryKey {
  IntColumn get chatId => integer().references(Chats, #id)();
  TextColumn get role => text()();
  TextColumn get content => text()();
  BoolColumn get isResponse => boolean()();
  IntColumn get promptTokens => integer().nullable()();
  IntColumn get completionTokens => integer().nullable()();
  IntColumn get totalTokens => integer().nullable()();
  TextColumn get finishReason => text().nullable()();
  BoolColumn get isFavorite => boolean()();
  DateTimeColumn get msgDateTime => dateTime()();
}

class SystemPrompts extends Table with AutoIncrementingPrimaryKey {
  TextColumn get prompt => text()();
  DateTimeColumn get createDateTime => dateTime()();
}

@DriftDatabase(tables: [ChatTitles, Conversations, Chats, Messages, SystemPrompts])
class HaoDatabase extends _$HaoDatabase {
  HaoDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        for (var step = from + 1; step <= to; step++) {
          switch (step) {
            case 2:
              m.createTable(chats);
              m.createTable(messages);
              break;
            case 3:
              m.createTable(systemPrompts);
              break;
          }
        }
      },
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