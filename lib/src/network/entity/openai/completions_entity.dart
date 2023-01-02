import 'package:json_annotation/json_annotation.dart';

part 'completions_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CompletionsEntity {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<CompletionsChoiceEntity>? choices;
  final CompletionsUsageEntity? usage;

  CompletionsEntity(this.id, this.object, this.created, this.model, this.choices, this.usage);

  factory CompletionsEntity.fromJson(Map<String, dynamic> json) => _$CompletionsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionsEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompletionsChoiceEntity {
  final String? text;
  final int? index;
  final int? logprobs;

  /// stop, length
  @JsonKey(name: "finish_reason")
  final String? finishReason;

  CompletionsChoiceEntity(this.text, this.index, this.logprobs, this.finishReason);

  factory CompletionsChoiceEntity.fromJson(Map<String, dynamic> json) => _$CompletionsChoiceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionsChoiceEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompletionsUsageEntity {
  @JsonKey(name: "prompt_tokens")
  final int? promptTokens;
  @JsonKey(name: "completion_tokens")
  final int? completionTokens;
  @JsonKey(name: "total_tokens")
  final int? totalTokens;

  CompletionsUsageEntity(this.promptTokens, this.completionTokens, this.totalTokens);

  factory CompletionsUsageEntity.fromJson(Map<String, dynamic> json) => _$CompletionsUsageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionsUsageEntityToJson(this);
}
