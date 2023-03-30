// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_query_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatQueryEntity _$ChatQueryEntityFromJson(Map<String, dynamic> json) =>
    ChatQueryEntity(
      model: json['model'] as String?,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => ChatMessageEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.7,
      topP: (json['top_p'] as num?)?.toDouble() ?? 1.0,
      numOfChoices: json['n'] as int? ?? 1,
      stream: json['stream'] as bool? ?? false,
      stop: (json['stop'] as List<dynamic>?)?.map((e) => e as String).toList(),
      maxTokens: json['max_tokens'] as int? ?? 256,
      presencePenalty: (json['presence_penalty'] as num?)?.toDouble() ?? 0.0,
      frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ChatQueryEntityToJson(ChatQueryEntity instance) =>
    <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'temperature': instance.temperature,
      'top_p': instance.topP,
      'n': instance.numOfChoices,
      'stream': instance.stream,
      'stop': instance.stop,
      'max_tokens': instance.maxTokens,
      'presence_penalty': instance.presencePenalty,
      'frequency_penalty': instance.frequencyPenalty,
    };
