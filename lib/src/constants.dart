import 'dart:core';
import 'dart:ui';

class Constants {
  static const String splitTag = '<|>';
  static const String gpt3ModelDavinci003 = 'text-davinci-003';
  static const String gpt3ModelCurie001 = 'text-curie-001';
  static const String gpt3ModelBabbage001 = 'text-babbage-001';
  static const String gpt3ModelAda001 = 'text-ada-001';
  static const List<String> gpt3Models = [
    gpt3ModelDavinci003,
    gpt3ModelCurie001,
    gpt3ModelBabbage001,
    gpt3ModelAda001
  ];

  static const Locale enLocale = Locale('en', '');
  static const Locale zhLocale = Locale('zh', '');

  static const String aboutChatGPTUrl = 'https://openai.com/blog/chatgpt/';
  static const String aboutGPT3ModelsUrl =
      'https://beta.openai.com/docs/models/gpt-3';
  static const String aboutGPT35ModelsUrl =
      'https://platform.openai.com/docs/models/gpt-3-5';
  static const String aboutCodexModelsUrl =
      'https://beta.openai.com/docs/models/codex';
  static const String apiCompletionsUrl =
      'https://platform.openai.com/docs/api-reference/completions/create';
  static const String apiReferenceChatUrl =
      'https://platform.openai.com/docs/api-reference/chat/create';
  static const String haoChatGitHubUrl =
      'https://github.com/conghaonet/hao_chatgpt';
  static const String openAiApiKeysUrl =
      'https://beta.openai.com/account/api-keys';

  static const String blankUrl = 'about:blank';

  static const String androidActionMain = 'android.intent.action.MAIN';
  static const String androidCategoryHome = 'android.intent.category.HOME';

  static const int systemPromptLimit = 10;
}

class ChatRole {
  static const system = 'system', user = 'user', assistant = 'assistant';
}

class FinishReason {
  static const length = 'length', stop = 'stop';
}

enum GptModel {
  gpt35Turbo(model: 'gpt-3.5-turbo', maxTokens: 4096);

  const GptModel({required this.model, required this.maxTokens});

  final String model;
  final int maxTokens;
}