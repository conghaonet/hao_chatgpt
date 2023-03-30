import 'package:hao_chatgpt/src/constants.dart';
import 'package:hao_chatgpt/src/network/entity/openai/chat_message_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_query_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatQueryEntity {
  /// ID of the model to use. Currently, only gpt-3.5-turbo and gpt-3.5-turbo-0301 are supported.
  String model;

  /// The messages to generate chat completions for, in the chat format.
  List<ChatMessageEntity> messages;

  /// 更高的值意味着模型将承担更多的风险。
  /// 对于更有创意的应用程序，可以尝试0.9，对于有明确答案的应用程序，可以尝试0。
  @JsonKey(defaultValue: 0.7)
  double temperature;

  /// An alternative to sampling with temperature, called nucleus sampling,
  /// where the model considers the results of the tokens with top_p probability mass.
  /// So 0.1 means only the tokens comprising the top 10% probability mass are considered.
  /// We generally recommend altering this or temperature but not both.
  @JsonKey(name: 'top_p', defaultValue: 1.0)
  double topP;

  /// How many chat completion choices to generate for each input message.
  @JsonKey(name: 'n', defaultValue: 1)
  int numOfChoices;

  /// If set, partial message deltas will be sent, like in ChatGPT.
  /// Tokens will be sent as data-only server-sent events as they become available,
  /// with the stream terminated by a data: [DONE] message.
  @JsonKey(defaultValue: false)
  bool stream;

  /// Up to 4 sequences where the API will stop generating further tokens.
  List<String>? stop;

  /// The maximum number of tokens allowed for the generated answer.
  /// By default, the number of tokens the model can return will be (4096 - prompt tokens).
  @JsonKey(name: 'max_tokens', defaultValue: 256)
  int maxTokens;

  /// Number between -2.0 and 2.0.
  /// Positive values penalize new tokens based on whether they appear in the text so far,
  /// increasing the model's likelihood to talk about new topics.
  @JsonKey(name: 'presence_penalty', defaultValue: 0.0)
  double presencePenalty;

  /// Number between -2.0 and 2.0.
  /// Positive values penalize new tokens based on their existing frequency in the text so far,
  /// decreasing the model's likelihood to repeat the same line verbatim.
  @JsonKey(name: 'frequency_penalty', defaultValue: 0.0)
  double frequencyPenalty;

  ChatQueryEntity({
    String? model,
    required this.messages,
    this.temperature = 0.7,
    this.topP = 1.0,
    this.numOfChoices = 1,
    this.stream = false,
    this.stop,
    this.maxTokens = 256,
    this.presencePenalty = 0.0,
    this.frequencyPenalty = 0.0
  }) : model = model ?? GptModel.gpt35Turbo.model;
  factory ChatQueryEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatQueryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatQueryEntityToJson(this);
}
