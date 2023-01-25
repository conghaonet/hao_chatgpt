// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hao_database.dart';

// ignore_for_file: type=lint
class $ChatTitlesTable extends ChatTitles
    with TableInfo<$ChatTitlesTable, ChatTitle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatTitlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite =
      GeneratedColumn<bool>('is_favorite', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_favorite" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _chatDateMeta =
      const VerificationMeta('chatDate');
  @override
  late final GeneratedColumn<DateTime> chatDate = GeneratedColumn<DateTime>(
      'chat_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, isFavorite, chatDate];
  @override
  String get aliasedName => _alias ?? 'chat_titles';
  @override
  String get actualTableName => 'chat_titles';
  @override
  VerificationContext validateIntegrity(Insertable<ChatTitle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('chat_date')) {
      context.handle(_chatDateMeta,
          chatDate.isAcceptableOrUnknown(data['chat_date']!, _chatDateMeta));
    } else if (isInserting) {
      context.missing(_chatDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatTitle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatTitle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite']),
      chatDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}chat_date'])!,
    );
  }

  @override
  $ChatTitlesTable createAlias(String alias) {
    return $ChatTitlesTable(attachedDatabase, alias);
  }
}

class ChatTitle extends DataClass implements Insertable<ChatTitle> {
  final int id;
  final String title;
  final bool? isFavorite;
  final DateTime chatDate;
  const ChatTitle(
      {required this.id,
      required this.title,
      this.isFavorite,
      required this.chatDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || isFavorite != null) {
      map['is_favorite'] = Variable<bool>(isFavorite);
    }
    map['chat_date'] = Variable<DateTime>(chatDate);
    return map;
  }

  ChatTitlesCompanion toCompanion(bool nullToAbsent) {
    return ChatTitlesCompanion(
      id: Value(id),
      title: Value(title),
      isFavorite: isFavorite == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavorite),
      chatDate: Value(chatDate),
    );
  }

  factory ChatTitle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatTitle(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      isFavorite: serializer.fromJson<bool?>(json['isFavorite']),
      chatDate: serializer.fromJson<DateTime>(json['chatDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'isFavorite': serializer.toJson<bool?>(isFavorite),
      'chatDate': serializer.toJson<DateTime>(chatDate),
    };
  }

  ChatTitle copyWith(
          {int? id,
          String? title,
          Value<bool?> isFavorite = const Value.absent(),
          DateTime? chatDate}) =>
      ChatTitle(
        id: id ?? this.id,
        title: title ?? this.title,
        isFavorite: isFavorite.present ? isFavorite.value : this.isFavorite,
        chatDate: chatDate ?? this.chatDate,
      );
  @override
  String toString() {
    return (StringBuffer('ChatTitle(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('chatDate: $chatDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, isFavorite, chatDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatTitle &&
          other.id == this.id &&
          other.title == this.title &&
          other.isFavorite == this.isFavorite &&
          other.chatDate == this.chatDate);
}

class ChatTitlesCompanion extends UpdateCompanion<ChatTitle> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool?> isFavorite;
  final Value<DateTime> chatDate;
  const ChatTitlesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.chatDate = const Value.absent(),
  });
  ChatTitlesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.isFavorite = const Value.absent(),
    required DateTime chatDate,
  })  : title = Value(title),
        chatDate = Value(chatDate);
  static Insertable<ChatTitle> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<bool>? isFavorite,
    Expression<DateTime>? chatDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (chatDate != null) 'chat_date': chatDate,
    });
  }

  ChatTitlesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<bool?>? isFavorite,
      Value<DateTime>? chatDate}) {
    return ChatTitlesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      chatDate: chatDate ?? this.chatDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (chatDate.present) {
      map['chat_date'] = Variable<DateTime>(chatDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatTitlesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('chatDate: $chatDate')
          ..write(')'))
        .toString();
  }
}

class $ConversationsTable extends Conversations
    with TableInfo<$ConversationsTable, Conversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleIdMeta =
      const VerificationMeta('titleId');
  @override
  late final GeneratedColumn<int> titleId = GeneratedColumn<int>(
      'title_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chat_titles (id)'));
  static const VerificationMeta _inputMessageMeta =
      const VerificationMeta('inputMessage');
  @override
  late final GeneratedColumn<String> inputMessage = GeneratedColumn<String>(
      'input_message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
      'prompt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completionMeta =
      const VerificationMeta('completion');
  @override
  late final GeneratedColumn<String> completion = GeneratedColumn<String>(
      'completion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isErrorMeta =
      const VerificationMeta('isError');
  @override
  late final GeneratedColumn<bool> isError =
      GeneratedColumn<bool>('is_error', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_error" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _promptDateMeta =
      const VerificationMeta('promptDate');
  @override
  late final GeneratedColumn<DateTime> promptDate = GeneratedColumn<DateTime>(
      'prompt_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, titleId, inputMessage, prompt, completion, isError, promptDate];
  @override
  String get aliasedName => _alias ?? 'conversations';
  @override
  String get actualTableName => 'conversations';
  @override
  VerificationContext validateIntegrity(Insertable<Conversation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title_id')) {
      context.handle(_titleIdMeta,
          titleId.isAcceptableOrUnknown(data['title_id']!, _titleIdMeta));
    } else if (isInserting) {
      context.missing(_titleIdMeta);
    }
    if (data.containsKey('input_message')) {
      context.handle(
          _inputMessageMeta,
          inputMessage.isAcceptableOrUnknown(
              data['input_message']!, _inputMessageMeta));
    } else if (isInserting) {
      context.missing(_inputMessageMeta);
    }
    if (data.containsKey('prompt')) {
      context.handle(_promptMeta,
          prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta));
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('completion')) {
      context.handle(
          _completionMeta,
          completion.isAcceptableOrUnknown(
              data['completion']!, _completionMeta));
    }
    if (data.containsKey('is_error')) {
      context.handle(_isErrorMeta,
          isError.isAcceptableOrUnknown(data['is_error']!, _isErrorMeta));
    }
    if (data.containsKey('prompt_date')) {
      context.handle(
          _promptDateMeta,
          promptDate.isAcceptableOrUnknown(
              data['prompt_date']!, _promptDateMeta));
    } else if (isInserting) {
      context.missing(_promptDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Conversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Conversation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      titleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}title_id'])!,
      inputMessage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}input_message'])!,
      prompt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prompt'])!,
      completion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}completion']),
      isError: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_error']),
      promptDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}prompt_date'])!,
    );
  }

  @override
  $ConversationsTable createAlias(String alias) {
    return $ConversationsTable(attachedDatabase, alias);
  }
}

class Conversation extends DataClass implements Insertable<Conversation> {
  final int id;
  final int titleId;
  final String inputMessage;
  final String prompt;
  final String? completion;
  final bool? isError;
  final DateTime promptDate;
  const Conversation(
      {required this.id,
      required this.titleId,
      required this.inputMessage,
      required this.prompt,
      this.completion,
      this.isError,
      required this.promptDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title_id'] = Variable<int>(titleId);
    map['input_message'] = Variable<String>(inputMessage);
    map['prompt'] = Variable<String>(prompt);
    if (!nullToAbsent || completion != null) {
      map['completion'] = Variable<String>(completion);
    }
    if (!nullToAbsent || isError != null) {
      map['is_error'] = Variable<bool>(isError);
    }
    map['prompt_date'] = Variable<DateTime>(promptDate);
    return map;
  }

  ConversationsCompanion toCompanion(bool nullToAbsent) {
    return ConversationsCompanion(
      id: Value(id),
      titleId: Value(titleId),
      inputMessage: Value(inputMessage),
      prompt: Value(prompt),
      completion: completion == null && nullToAbsent
          ? const Value.absent()
          : Value(completion),
      isError: isError == null && nullToAbsent
          ? const Value.absent()
          : Value(isError),
      promptDate: Value(promptDate),
    );
  }

  factory Conversation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Conversation(
      id: serializer.fromJson<int>(json['id']),
      titleId: serializer.fromJson<int>(json['titleId']),
      inputMessage: serializer.fromJson<String>(json['inputMessage']),
      prompt: serializer.fromJson<String>(json['prompt']),
      completion: serializer.fromJson<String?>(json['completion']),
      isError: serializer.fromJson<bool?>(json['isError']),
      promptDate: serializer.fromJson<DateTime>(json['promptDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'titleId': serializer.toJson<int>(titleId),
      'inputMessage': serializer.toJson<String>(inputMessage),
      'prompt': serializer.toJson<String>(prompt),
      'completion': serializer.toJson<String?>(completion),
      'isError': serializer.toJson<bool?>(isError),
      'promptDate': serializer.toJson<DateTime>(promptDate),
    };
  }

  Conversation copyWith(
          {int? id,
          int? titleId,
          String? inputMessage,
          String? prompt,
          Value<String?> completion = const Value.absent(),
          Value<bool?> isError = const Value.absent(),
          DateTime? promptDate}) =>
      Conversation(
        id: id ?? this.id,
        titleId: titleId ?? this.titleId,
        inputMessage: inputMessage ?? this.inputMessage,
        prompt: prompt ?? this.prompt,
        completion: completion.present ? completion.value : this.completion,
        isError: isError.present ? isError.value : this.isError,
        promptDate: promptDate ?? this.promptDate,
      );
  @override
  String toString() {
    return (StringBuffer('Conversation(')
          ..write('id: $id, ')
          ..write('titleId: $titleId, ')
          ..write('inputMessage: $inputMessage, ')
          ..write('prompt: $prompt, ')
          ..write('completion: $completion, ')
          ..write('isError: $isError, ')
          ..write('promptDate: $promptDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, titleId, inputMessage, prompt, completion, isError, promptDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Conversation &&
          other.id == this.id &&
          other.titleId == this.titleId &&
          other.inputMessage == this.inputMessage &&
          other.prompt == this.prompt &&
          other.completion == this.completion &&
          other.isError == this.isError &&
          other.promptDate == this.promptDate);
}

class ConversationsCompanion extends UpdateCompanion<Conversation> {
  final Value<int> id;
  final Value<int> titleId;
  final Value<String> inputMessage;
  final Value<String> prompt;
  final Value<String?> completion;
  final Value<bool?> isError;
  final Value<DateTime> promptDate;
  const ConversationsCompanion({
    this.id = const Value.absent(),
    this.titleId = const Value.absent(),
    this.inputMessage = const Value.absent(),
    this.prompt = const Value.absent(),
    this.completion = const Value.absent(),
    this.isError = const Value.absent(),
    this.promptDate = const Value.absent(),
  });
  ConversationsCompanion.insert({
    this.id = const Value.absent(),
    required int titleId,
    required String inputMessage,
    required String prompt,
    this.completion = const Value.absent(),
    this.isError = const Value.absent(),
    required DateTime promptDate,
  })  : titleId = Value(titleId),
        inputMessage = Value(inputMessage),
        prompt = Value(prompt),
        promptDate = Value(promptDate);
  static Insertable<Conversation> custom({
    Expression<int>? id,
    Expression<int>? titleId,
    Expression<String>? inputMessage,
    Expression<String>? prompt,
    Expression<String>? completion,
    Expression<bool>? isError,
    Expression<DateTime>? promptDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titleId != null) 'title_id': titleId,
      if (inputMessage != null) 'input_message': inputMessage,
      if (prompt != null) 'prompt': prompt,
      if (completion != null) 'completion': completion,
      if (isError != null) 'is_error': isError,
      if (promptDate != null) 'prompt_date': promptDate,
    });
  }

  ConversationsCompanion copyWith(
      {Value<int>? id,
      Value<int>? titleId,
      Value<String>? inputMessage,
      Value<String>? prompt,
      Value<String?>? completion,
      Value<bool?>? isError,
      Value<DateTime>? promptDate}) {
    return ConversationsCompanion(
      id: id ?? this.id,
      titleId: titleId ?? this.titleId,
      inputMessage: inputMessage ?? this.inputMessage,
      prompt: prompt ?? this.prompt,
      completion: completion ?? this.completion,
      isError: isError ?? this.isError,
      promptDate: promptDate ?? this.promptDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (titleId.present) {
      map['title_id'] = Variable<int>(titleId.value);
    }
    if (inputMessage.present) {
      map['input_message'] = Variable<String>(inputMessage.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (completion.present) {
      map['completion'] = Variable<String>(completion.value);
    }
    if (isError.present) {
      map['is_error'] = Variable<bool>(isError.value);
    }
    if (promptDate.present) {
      map['prompt_date'] = Variable<DateTime>(promptDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConversationsCompanion(')
          ..write('id: $id, ')
          ..write('titleId: $titleId, ')
          ..write('inputMessage: $inputMessage, ')
          ..write('prompt: $prompt, ')
          ..write('completion: $completion, ')
          ..write('isError: $isError, ')
          ..write('promptDate: $promptDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$HaoDatabase extends GeneratedDatabase {
  _$HaoDatabase(QueryExecutor e) : super(e);
  late final $ChatTitlesTable chatTitles = $ChatTitlesTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chatTitles, conversations];
}
