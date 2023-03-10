// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_usage_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionUsageEntity _$CompletionUsageEntityFromJson(
        Map<String, dynamic> json) =>
    CompletionUsageEntity(
      json['prompt_tokens'] as int?,
      json['completion_tokens'] as int?,
      json['total_tokens'] as int?,
    );

Map<String, dynamic> _$CompletionUsageEntityToJson(
        CompletionUsageEntity instance) =>
    <String, dynamic>{
      'prompt_tokens': instance.promptTokens,
      'completion_tokens': instance.completionTokens,
      'total_tokens': instance.totalTokens,
    };
