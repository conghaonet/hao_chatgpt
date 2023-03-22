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

class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _systemMeta = const VerificationMeta('system');
  @override
  late final GeneratedColumn<String> system = GeneratedColumn<String>(
      'system', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite =
      GeneratedColumn<bool>('is_favorite', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_favorite" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _chatDateTimeMeta =
      const VerificationMeta('chatDateTime');
  @override
  late final GeneratedColumn<DateTime> chatDateTime = GeneratedColumn<DateTime>(
      'chat_date_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, system, isFavorite, chatDateTime];
  @override
  String get aliasedName => _alias ?? 'chats';
  @override
  String get actualTableName => 'chats';
  @override
  VerificationContext validateIntegrity(Insertable<Chat> instance,
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
    if (data.containsKey('system')) {
      context.handle(_systemMeta,
          system.isAcceptableOrUnknown(data['system']!, _systemMeta));
    } else if (isInserting) {
      context.missing(_systemMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    if (data.containsKey('chat_date_time')) {
      context.handle(
          _chatDateTimeMeta,
          chatDateTime.isAcceptableOrUnknown(
              data['chat_date_time']!, _chatDateTimeMeta));
    } else if (isInserting) {
      context.missing(_chatDateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Chat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      system: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}system'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      chatDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}chat_date_time'])!,
    );
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final int id;
  final String title;
  final String system;
  final bool isFavorite;
  final DateTime chatDateTime;
  const Chat(
      {required this.id,
      required this.title,
      required this.system,
      required this.isFavorite,
      required this.chatDateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['system'] = Variable<String>(system);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['chat_date_time'] = Variable<DateTime>(chatDateTime);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      id: Value(id),
      title: Value(title),
      system: Value(system),
      isFavorite: Value(isFavorite),
      chatDateTime: Value(chatDateTime),
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      system: serializer.fromJson<String>(json['system']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      chatDateTime: serializer.fromJson<DateTime>(json['chatDateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'system': serializer.toJson<String>(system),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'chatDateTime': serializer.toJson<DateTime>(chatDateTime),
    };
  }

  Chat copyWith(
          {int? id,
          String? title,
          String? system,
          bool? isFavorite,
          DateTime? chatDateTime}) =>
      Chat(
        id: id ?? this.id,
        title: title ?? this.title,
        system: system ?? this.system,
        isFavorite: isFavorite ?? this.isFavorite,
        chatDateTime: chatDateTime ?? this.chatDateTime,
      );
  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('system: $system, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('chatDateTime: $chatDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, system, isFavorite, chatDateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.id == this.id &&
          other.title == this.title &&
          other.system == this.system &&
          other.isFavorite == this.isFavorite &&
          other.chatDateTime == this.chatDateTime);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> system;
  final Value<bool> isFavorite;
  final Value<DateTime> chatDateTime;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.system = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.chatDateTime = const Value.absent(),
  });
  ChatsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String system,
    required bool isFavorite,
    required DateTime chatDateTime,
  })  : title = Value(title),
        system = Value(system),
        isFavorite = Value(isFavorite),
        chatDateTime = Value(chatDateTime);
  static Insertable<Chat> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? system,
    Expression<bool>? isFavorite,
    Expression<DateTime>? chatDateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (system != null) 'system': system,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (chatDateTime != null) 'chat_date_time': chatDateTime,
    });
  }

  ChatsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? system,
      Value<bool>? isFavorite,
      Value<DateTime>? chatDateTime}) {
    return ChatsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      system: system ?? this.system,
      isFavorite: isFavorite ?? this.isFavorite,
      chatDateTime: chatDateTime ?? this.chatDateTime,
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
    if (system.present) {
      map['system'] = Variable<String>(system.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (chatDateTime.present) {
      map['chat_date_time'] = Variable<DateTime>(chatDateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('system: $system, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('chatDateTime: $chatDateTime')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES chats (id)'));
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isResponseMeta =
      const VerificationMeta('isResponse');
  @override
  late final GeneratedColumn<bool> isResponse =
      GeneratedColumn<bool>('is_response', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_response" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _promptTokensMeta =
      const VerificationMeta('promptTokens');
  @override
  late final GeneratedColumn<int> promptTokens = GeneratedColumn<int>(
      'prompt_tokens', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _completionTokensMeta =
      const VerificationMeta('completionTokens');
  @override
  late final GeneratedColumn<int> completionTokens = GeneratedColumn<int>(
      'completion_tokens', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalTokensMeta =
      const VerificationMeta('totalTokens');
  @override
  late final GeneratedColumn<int> totalTokens = GeneratedColumn<int>(
      'total_tokens', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _finishReasonMeta =
      const VerificationMeta('finishReason');
  @override
  late final GeneratedColumn<String> finishReason = GeneratedColumn<String>(
      'finish_reason', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite =
      GeneratedColumn<bool>('is_favorite', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_favorite" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _msgDateTimeMeta =
      const VerificationMeta('msgDateTime');
  @override
  late final GeneratedColumn<DateTime> msgDateTime = GeneratedColumn<DateTime>(
      'msg_date_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        chatId,
        role,
        content,
        isResponse,
        promptTokens,
        completionTokens,
        totalTokens,
        finishReason,
        isFavorite,
        msgDateTime
      ];
  @override
  String get aliasedName => _alias ?? 'messages';
  @override
  String get actualTableName => 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('is_response')) {
      context.handle(
          _isResponseMeta,
          isResponse.isAcceptableOrUnknown(
              data['is_response']!, _isResponseMeta));
    } else if (isInserting) {
      context.missing(_isResponseMeta);
    }
    if (data.containsKey('prompt_tokens')) {
      context.handle(
          _promptTokensMeta,
          promptTokens.isAcceptableOrUnknown(
              data['prompt_tokens']!, _promptTokensMeta));
    }
    if (data.containsKey('completion_tokens')) {
      context.handle(
          _completionTokensMeta,
          completionTokens.isAcceptableOrUnknown(
              data['completion_tokens']!, _completionTokensMeta));
    }
    if (data.containsKey('total_tokens')) {
      context.handle(
          _totalTokensMeta,
          totalTokens.isAcceptableOrUnknown(
              data['total_tokens']!, _totalTokensMeta));
    }
    if (data.containsKey('finish_reason')) {
      context.handle(
          _finishReasonMeta,
          finishReason.isAcceptableOrUnknown(
              data['finish_reason']!, _finishReasonMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    if (data.containsKey('msg_date_time')) {
      context.handle(
          _msgDateTimeMeta,
          msgDateTime.isAcceptableOrUnknown(
              data['msg_date_time']!, _msgDateTimeMeta));
    } else if (isInserting) {
      context.missing(_msgDateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Message(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      isResponse: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_response'])!,
      promptTokens: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}prompt_tokens']),
      completionTokens: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completion_tokens']),
      totalTokens: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_tokens']),
      finishReason: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}finish_reason']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      msgDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}msg_date_time'])!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final int chatId;
  final String role;
  final String content;
  final bool isResponse;
  final int? promptTokens;
  final int? completionTokens;
  final int? totalTokens;
  final String? finishReason;
  final bool isFavorite;
  final DateTime msgDateTime;
  const Message(
      {required this.id,
      required this.chatId,
      required this.role,
      required this.content,
      required this.isResponse,
      this.promptTokens,
      this.completionTokens,
      this.totalTokens,
      this.finishReason,
      required this.isFavorite,
      required this.msgDateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chatId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['is_response'] = Variable<bool>(isResponse);
    if (!nullToAbsent || promptTokens != null) {
      map['prompt_tokens'] = Variable<int>(promptTokens);
    }
    if (!nullToAbsent || completionTokens != null) {
      map['completion_tokens'] = Variable<int>(completionTokens);
    }
    if (!nullToAbsent || totalTokens != null) {
      map['total_tokens'] = Variable<int>(totalTokens);
    }
    if (!nullToAbsent || finishReason != null) {
      map['finish_reason'] = Variable<String>(finishReason);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['msg_date_time'] = Variable<DateTime>(msgDateTime);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      chatId: Value(chatId),
      role: Value(role),
      content: Value(content),
      isResponse: Value(isResponse),
      promptTokens: promptTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(promptTokens),
      completionTokens: completionTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(completionTokens),
      totalTokens: totalTokens == null && nullToAbsent
          ? const Value.absent()
          : Value(totalTokens),
      finishReason: finishReason == null && nullToAbsent
          ? const Value.absent()
          : Value(finishReason),
      isFavorite: Value(isFavorite),
      msgDateTime: Value(msgDateTime),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      chatId: serializer.fromJson<int>(json['chatId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      isResponse: serializer.fromJson<bool>(json['isResponse']),
      promptTokens: serializer.fromJson<int?>(json['promptTokens']),
      completionTokens: serializer.fromJson<int?>(json['completionTokens']),
      totalTokens: serializer.fromJson<int?>(json['totalTokens']),
      finishReason: serializer.fromJson<String?>(json['finishReason']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      msgDateTime: serializer.fromJson<DateTime>(json['msgDateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chatId': serializer.toJson<int>(chatId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'isResponse': serializer.toJson<bool>(isResponse),
      'promptTokens': serializer.toJson<int?>(promptTokens),
      'completionTokens': serializer.toJson<int?>(completionTokens),
      'totalTokens': serializer.toJson<int?>(totalTokens),
      'finishReason': serializer.toJson<String?>(finishReason),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'msgDateTime': serializer.toJson<DateTime>(msgDateTime),
    };
  }

  Message copyWith(
          {int? id,
          int? chatId,
          String? role,
          String? content,
          bool? isResponse,
          Value<int?> promptTokens = const Value.absent(),
          Value<int?> completionTokens = const Value.absent(),
          Value<int?> totalTokens = const Value.absent(),
          Value<String?> finishReason = const Value.absent(),
          bool? isFavorite,
          DateTime? msgDateTime}) =>
      Message(
        id: id ?? this.id,
        chatId: chatId ?? this.chatId,
        role: role ?? this.role,
        content: content ?? this.content,
        isResponse: isResponse ?? this.isResponse,
        promptTokens:
            promptTokens.present ? promptTokens.value : this.promptTokens,
        completionTokens: completionTokens.present
            ? completionTokens.value
            : this.completionTokens,
        totalTokens: totalTokens.present ? totalTokens.value : this.totalTokens,
        finishReason:
            finishReason.present ? finishReason.value : this.finishReason,
        isFavorite: isFavorite ?? this.isFavorite,
        msgDateTime: msgDateTime ?? this.msgDateTime,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('isResponse: $isResponse, ')
          ..write('promptTokens: $promptTokens, ')
          ..write('completionTokens: $completionTokens, ')
          ..write('totalTokens: $totalTokens, ')
          ..write('finishReason: $finishReason, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('msgDateTime: $msgDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      chatId,
      role,
      content,
      isResponse,
      promptTokens,
      completionTokens,
      totalTokens,
      finishReason,
      isFavorite,
      msgDateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.role == this.role &&
          other.content == this.content &&
          other.isResponse == this.isResponse &&
          other.promptTokens == this.promptTokens &&
          other.completionTokens == this.completionTokens &&
          other.totalTokens == this.totalTokens &&
          other.finishReason == this.finishReason &&
          other.isFavorite == this.isFavorite &&
          other.msgDateTime == this.msgDateTime);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<int> chatId;
  final Value<String> role;
  final Value<String> content;
  final Value<bool> isResponse;
  final Value<int?> promptTokens;
  final Value<int?> completionTokens;
  final Value<int?> totalTokens;
  final Value<String?> finishReason;
  final Value<bool> isFavorite;
  final Value<DateTime> msgDateTime;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.isResponse = const Value.absent(),
    this.promptTokens = const Value.absent(),
    this.completionTokens = const Value.absent(),
    this.totalTokens = const Value.absent(),
    this.finishReason = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.msgDateTime = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required int chatId,
    required String role,
    required String content,
    required bool isResponse,
    this.promptTokens = const Value.absent(),
    this.completionTokens = const Value.absent(),
    this.totalTokens = const Value.absent(),
    this.finishReason = const Value.absent(),
    required bool isFavorite,
    required DateTime msgDateTime,
  })  : chatId = Value(chatId),
        role = Value(role),
        content = Value(content),
        isResponse = Value(isResponse),
        isFavorite = Value(isFavorite),
        msgDateTime = Value(msgDateTime);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<int>? chatId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<bool>? isResponse,
    Expression<int>? promptTokens,
    Expression<int>? completionTokens,
    Expression<int>? totalTokens,
    Expression<String>? finishReason,
    Expression<bool>? isFavorite,
    Expression<DateTime>? msgDateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (isResponse != null) 'is_response': isResponse,
      if (promptTokens != null) 'prompt_tokens': promptTokens,
      if (completionTokens != null) 'completion_tokens': completionTokens,
      if (totalTokens != null) 'total_tokens': totalTokens,
      if (finishReason != null) 'finish_reason': finishReason,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (msgDateTime != null) 'msg_date_time': msgDateTime,
    });
  }

  MessagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? chatId,
      Value<String>? role,
      Value<String>? content,
      Value<bool>? isResponse,
      Value<int?>? promptTokens,
      Value<int?>? completionTokens,
      Value<int?>? totalTokens,
      Value<String?>? finishReason,
      Value<bool>? isFavorite,
      Value<DateTime>? msgDateTime}) {
    return MessagesCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      role: role ?? this.role,
      content: content ?? this.content,
      isResponse: isResponse ?? this.isResponse,
      promptTokens: promptTokens ?? this.promptTokens,
      completionTokens: completionTokens ?? this.completionTokens,
      totalTokens: totalTokens ?? this.totalTokens,
      finishReason: finishReason ?? this.finishReason,
      isFavorite: isFavorite ?? this.isFavorite,
      msgDateTime: msgDateTime ?? this.msgDateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (isResponse.present) {
      map['is_response'] = Variable<bool>(isResponse.value);
    }
    if (promptTokens.present) {
      map['prompt_tokens'] = Variable<int>(promptTokens.value);
    }
    if (completionTokens.present) {
      map['completion_tokens'] = Variable<int>(completionTokens.value);
    }
    if (totalTokens.present) {
      map['total_tokens'] = Variable<int>(totalTokens.value);
    }
    if (finishReason.present) {
      map['finish_reason'] = Variable<String>(finishReason.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (msgDateTime.present) {
      map['msg_date_time'] = Variable<DateTime>(msgDateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('isResponse: $isResponse, ')
          ..write('promptTokens: $promptTokens, ')
          ..write('completionTokens: $completionTokens, ')
          ..write('totalTokens: $totalTokens, ')
          ..write('finishReason: $finishReason, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('msgDateTime: $msgDateTime')
          ..write(')'))
        .toString();
  }
}

class $SystemPromptsTable extends SystemPrompts
    with TableInfo<$SystemPromptsTable, SystemPrompt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SystemPromptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _promptMeta = const VerificationMeta('prompt');
  @override
  late final GeneratedColumn<String> prompt = GeneratedColumn<String>(
      'prompt', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createDateTimeMeta =
      const VerificationMeta('createDateTime');
  @override
  late final GeneratedColumn<DateTime> createDateTime =
      GeneratedColumn<DateTime>('create_date_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, prompt, createDateTime];
  @override
  String get aliasedName => _alias ?? 'system_prompts';
  @override
  String get actualTableName => 'system_prompts';
  @override
  VerificationContext validateIntegrity(Insertable<SystemPrompt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('prompt')) {
      context.handle(_promptMeta,
          prompt.isAcceptableOrUnknown(data['prompt']!, _promptMeta));
    } else if (isInserting) {
      context.missing(_promptMeta);
    }
    if (data.containsKey('create_date_time')) {
      context.handle(
          _createDateTimeMeta,
          createDateTime.isAcceptableOrUnknown(
              data['create_date_time']!, _createDateTimeMeta));
    } else if (isInserting) {
      context.missing(_createDateTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SystemPrompt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SystemPrompt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      prompt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}prompt'])!,
      createDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}create_date_time'])!,
    );
  }

  @override
  $SystemPromptsTable createAlias(String alias) {
    return $SystemPromptsTable(attachedDatabase, alias);
  }
}

class SystemPrompt extends DataClass implements Insertable<SystemPrompt> {
  final int id;
  final String prompt;
  final DateTime createDateTime;
  const SystemPrompt(
      {required this.id, required this.prompt, required this.createDateTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['prompt'] = Variable<String>(prompt);
    map['create_date_time'] = Variable<DateTime>(createDateTime);
    return map;
  }

  SystemPromptsCompanion toCompanion(bool nullToAbsent) {
    return SystemPromptsCompanion(
      id: Value(id),
      prompt: Value(prompt),
      createDateTime: Value(createDateTime),
    );
  }

  factory SystemPrompt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SystemPrompt(
      id: serializer.fromJson<int>(json['id']),
      prompt: serializer.fromJson<String>(json['prompt']),
      createDateTime: serializer.fromJson<DateTime>(json['createDateTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'prompt': serializer.toJson<String>(prompt),
      'createDateTime': serializer.toJson<DateTime>(createDateTime),
    };
  }

  SystemPrompt copyWith({int? id, String? prompt, DateTime? createDateTime}) =>
      SystemPrompt(
        id: id ?? this.id,
        prompt: prompt ?? this.prompt,
        createDateTime: createDateTime ?? this.createDateTime,
      );
  @override
  String toString() {
    return (StringBuffer('SystemPrompt(')
          ..write('id: $id, ')
          ..write('prompt: $prompt, ')
          ..write('createDateTime: $createDateTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, prompt, createDateTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SystemPrompt &&
          other.id == this.id &&
          other.prompt == this.prompt &&
          other.createDateTime == this.createDateTime);
}

class SystemPromptsCompanion extends UpdateCompanion<SystemPrompt> {
  final Value<int> id;
  final Value<String> prompt;
  final Value<DateTime> createDateTime;
  const SystemPromptsCompanion({
    this.id = const Value.absent(),
    this.prompt = const Value.absent(),
    this.createDateTime = const Value.absent(),
  });
  SystemPromptsCompanion.insert({
    this.id = const Value.absent(),
    required String prompt,
    required DateTime createDateTime,
  })  : prompt = Value(prompt),
        createDateTime = Value(createDateTime);
  static Insertable<SystemPrompt> custom({
    Expression<int>? id,
    Expression<String>? prompt,
    Expression<DateTime>? createDateTime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (prompt != null) 'prompt': prompt,
      if (createDateTime != null) 'create_date_time': createDateTime,
    });
  }

  SystemPromptsCompanion copyWith(
      {Value<int>? id,
      Value<String>? prompt,
      Value<DateTime>? createDateTime}) {
    return SystemPromptsCompanion(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      createDateTime: createDateTime ?? this.createDateTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (prompt.present) {
      map['prompt'] = Variable<String>(prompt.value);
    }
    if (createDateTime.present) {
      map['create_date_time'] = Variable<DateTime>(createDateTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SystemPromptsCompanion(')
          ..write('id: $id, ')
          ..write('prompt: $prompt, ')
          ..write('createDateTime: $createDateTime')
          ..write(')'))
        .toString();
  }
}

abstract class _$HaoDatabase extends GeneratedDatabase {
  _$HaoDatabase(QueryExecutor e) : super(e);
  late final $ChatTitlesTable chatTitles = $ChatTitlesTable(this);
  late final $ConversationsTable conversations = $ConversationsTable(this);
  late final $ChatsTable chats = $ChatsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $SystemPromptsTable systemPrompts = $SystemPromptsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [chatTitles, conversations, chats, messages, systemPrompts];
}
