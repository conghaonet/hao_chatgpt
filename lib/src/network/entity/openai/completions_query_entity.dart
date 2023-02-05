import 'package:hao_chatgpt/src/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'completions_query_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class CompletionsQueryEntity {
  String model;
  String prompt;
  @JsonKey(name: 'max_tokens')
  int maxTokens;

  /// 更高的值意味着模型将承担更多的风险。
  /// 对于更有创意的应用程序，可以尝试0.9，对于有明确答案的应用程序，可以尝试0。
  @JsonKey(defaultValue: 0.9)
  double temperature;

  @JsonKey(name: 'top_p', defaultValue: 1.0)
  double topP;

  /// Number between -2.0 and 2.0.
  /// Positive values penalize new tokens based on their existing frequency in the text so far,
  /// decreasing the model's likelihood to repeat the same line verbatim.
  @JsonKey(name: 'frequency_penalty', defaultValue: 0.0)
  double frequencyPenalty;

  /// Number between -2.0 and 2.0.
  /// Positive values penalize new tokens based on whether they appear in the text so far,
  /// increasing the model's likelihood to talk about new topics.
  @JsonKey(name: 'presence_penalty', defaultValue: 0.0)
  double presencePenalty;

  List<String>? stop;

  /// https://beta.openai.com/docs/guides/completion/conversation
  CompletionsQueryEntity.conversation({
    this.model = Constants.gpt3ModelDavinci003,
    this.prompt = '',
    this.maxTokens = 150,
    this.temperature = 0.9,
    this.topP = 1.0,
    this.frequencyPenalty = 0.0,
    this.presencePenalty = 0.6,
    this.stop = const [" Human:", " AI:"],
  });

  /// https://beta.openai.com/docs/guides/completion/generation
  CompletionsQueryEntity.generation({
    this.model = Constants.gpt3ModelDavinci003,
    this.prompt = '',
    this.maxTokens = 150,
    this.temperature = 0.6,
    this.topP = 1.0,
    this.frequencyPenalty = 1.0,
    this.presencePenalty = 1.0,
    this.stop,
  });

  /// https://beta.openai.com/docs/guides/completion/translation
  CompletionsQueryEntity.translation({
    this.model = Constants.gpt3ModelDavinci003,
    this.prompt = '',
    this.maxTokens = 150,
    this.temperature = 0.3,
    this.topP = 1.0,
    this.frequencyPenalty = 0.0,
    this.presencePenalty = 0.0,
    this.stop,
  });

  CompletionsQueryEntity({
    required this.model,
    required this.prompt,
    this.maxTokens = 150,
    this.temperature = 0.9,
    this.topP = 1.0,
    this.frequencyPenalty = 0.0,
    this.presencePenalty = 0.0,
    this.stop,
  });

  factory CompletionsQueryEntity.fromJson(Map<String, dynamic> json) =>
      _$CompletionsQueryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CompletionsQueryEntityToJson(this);
}
