// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) => ChatEntity(
      json['id'] as String,
      json['object'] as String,
      json['created'] as int,
      json['model'] as String,
      (json['choices'] as List<dynamic>?)
          ?.map((e) => ChatChoiceEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['usage'] == null
          ? null
          : CompletionUsageEntity.fromJson(
              json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatEntityToJson(ChatEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices?.map((e) => e.toJson()).toList(),
      'usage': instance.usage?.toJson(),
    };

ChatChoiceEntity _$ChatChoiceEntityFromJson(Map<String, dynamic> json) =>
    ChatChoiceEntity(
      json['index'] as int?,
      json['message'] == null
          ? null
          : ChatMessageEntity.fromJson(json['message'] as Map<String, dynamic>),
      json['finish_reason'] as String?,
    );

Map<String, dynamic> _$ChatChoiceEntityToJson(ChatChoiceEntity instance) =>
    <String, dynamic>{
      'index': instance.index,
      'message': instance.message?.toJson(),
      'finish_reason': instance.finishReason,
    };
