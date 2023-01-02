// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completions_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionsEntity _$CompletionsEntityFromJson(Map<String, dynamic> json) =>
    CompletionsEntity(
      json['id'] as String,
      json['object'] as String,
      json['created'] as int,
      json['model'] as String,
      (json['choices'] as List<dynamic>?)
          ?.map((e) =>
              CompletionsChoiceEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['usage'] == null
          ? null
          : CompletionsUsageEntity.fromJson(
              json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompletionsEntityToJson(CompletionsEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'model': instance.model,
      'choices': instance.choices?.map((e) => e.toJson()).toList(),
      'usage': instance.usage?.toJson(),
    };

CompletionsChoiceEntity _$CompletionsChoiceEntityFromJson(
        Map<String, dynamic> json) =>
    CompletionsChoiceEntity(
      json['text'] as String?,
      json['index'] as int?,
      json['logprobs'] as int?,
      json['finish_reason'] as String?,
    );

Map<String, dynamic> _$CompletionsChoiceEntityToJson(
        CompletionsChoiceEntity instance) =>
    <String, dynamic>{
      'text': instance.text,
      'index': instance.index,
      'logprobs': instance.logprobs,
      'finish_reason': instance.finishReason,
    };

CompletionsUsageEntity _$CompletionsUsageEntityFromJson(
        Map<String, dynamic> json) =>
    CompletionsUsageEntity(
      json['prompt_tokens'] as int?,
      json['completion_tokens'] as int?,
      json['total_tokens'] as int?,
    );

Map<String, dynamic> _$CompletionsUsageEntityToJson(
        CompletionsUsageEntity instance) =>
    <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
    };
