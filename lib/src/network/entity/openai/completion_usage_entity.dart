import 'package:json_annotation/json_annotation.dart';

part 'completion_usage_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CompletionUsageEntity {
  @JsonKey(name: "prompt_tokens")
  final int? promptTokens;
  @JsonKey(name: "completion_tokens")
  final int? completionTokens;
  @JsonKey(name: "total_tokens")
  final int? totalTokens;

  CompletionUsageEntity(
      this.promptTokens, this.completionTokens, this.totalTokens);

  factory CompletionUsageEntity.fromJson(Map<String, dynamic> json) =>
      _$CompletionUsageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionUsageEntityToJson(this);
}