import 'package:hao_chatgpt/src/network/entity/openai/chat_message_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'completion_usage_entity.dart';

part 'chat_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatEntity {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<ChatChoiceEntity>? choices;
  final CompletionUsageEntity? usage;

  ChatEntity(
      this.id, this.object, this.created, this.model, this.choices, this.usage);

  factory ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChatChoiceEntity {
  final int? index;
  final ChatMessageEntity? message;
  /// stop, length
  @JsonKey(name: "finish_reason")
  final String? finishReason;

  ChatChoiceEntity(
      this.index, this.message, this.finishReason);

  factory ChatChoiceEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatChoiceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatChoiceEntityToJson(this);
}
