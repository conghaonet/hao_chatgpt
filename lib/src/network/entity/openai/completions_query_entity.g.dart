// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completions_query_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionsQueryEntity _$CompletionsQueryEntityFromJson(
        Map<String, dynamic> json) =>
    CompletionsQueryEntity(
      model: json['model'] as String,
      prompt: json['prompt'] as String,
      maxTokens: json['max_tokens'] as int? ?? 150,
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.9,
      topP: (json['top_p'] as num?)?.toDouble() ?? 1.0,
      frequencyPenalty: (json['frequency_penalty'] as num?)?.toDouble() ?? 0.0,
      presencePenalty: (json['presence_penalty'] as num?)?.toDouble() ?? 0.0,
      stop: (json['stop'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CompletionsQueryEntityToJson(
        CompletionsQueryEntity instance) =>
    <String, dynamic>{
      'model': instance.model,
      'prompt': instance.prompt,
      'max_tokens': instance.maxTokens,
      'temperature': instance.temperature,
      'top_p': instance.topP,
      'frequency_penalty': instance.frequencyPenalty,
      'presence_penalty': instance.presencePenalty,
      'stop': instance.stop,
    };
