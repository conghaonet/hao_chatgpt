import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get chooseTheme => 'Choose theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get systemDefault => 'System default';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get cancel => 'Cancel';

  @override
  String get settingsReset => 'Reset';

  @override
  String get about => 'About';

  @override
  String get prompt => 'Prompt';

  @override
  String get confirm => 'Confirm';

  @override
  String get remove => 'Remove';

  @override
  String get removeKeyNotice => 'This API key will immediately be removed.';

  @override
  String createdDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Created: $dateString';
  }

  @override
  String get default_ => 'Default';

  @override
  String get duplicateApiKey => 'Duplicate API key!';

  @override
  String get appDescription => 'An unofficial open-source ChatGPT application';

  @override
  String get resetToDefault => 'Reset to default';

  @override
  String get haoChatIsPoweredByOpenAI => 'HaoChat is powered by OpenAI';

  @override
  String get storeAPIkeyNotice => 'Please provide an OpenAI API key. This key will only be stored locally in your app cache.';

  @override
  String get enterYourOpenAiApiKey => 'Enter your OpenAI API key';

  @override
  String get done => 'Done';

  @override
  String get navigateTo => 'Navigate to';

  @override
  String get logInAndClick => 'Log in and click \"+ Create new secret key\"';

  @override
  String get newChat => 'New chat';

  @override
  String get deleteConversations => 'Delete conversations';

  @override
  String get confirmDelete => 'Confirm delete';

  @override
  String get selectAll => 'Select all';

  @override
  String get delete => 'Delete';

  @override
  String get home => 'Home';

  @override
  String get shortcuts => 'Shortcuts';

  @override
  String sendWith(String shortcut) {
    return 'Send with $shortcut';
  }

  @override
  String get httpProxy => 'HTTP Proxy';

  @override
  String get enableProxy => 'Enable proxy';

  @override
  String get hostName => 'Host name';

  @override
  String get portNumber => 'Port number';

  @override
  String get resume => 'Resume';

  @override
  String get systemPrompt => 'System prompt';

  @override
  String get retry => 'Retry';

  @override
  String get copied => 'Copied';

  @override
  String get defaultSystemPrompt => 'You are a helpful assistant.';

  @override
  String get systemPromptRecords => 'System prompt records';

  @override
  String get haoChat => 'HaoChat';

  @override
  String get openAI => 'OpenAI';

  @override
  String get chatGPT => 'ChatGPT';

  @override
  String get gpt35turbo => 'GPT-3.5-Turbo';

  @override
  String get langEnglish => 'English';

  @override
  String get langChinese => '简体中文';

  @override
  String get gpt3 => 'GPT-3';

  @override
  String get model => 'Model';

  @override
  String get temperature => 'Temperature';

  @override
  String get maximumLength => 'Maximum length';

  @override
  String get topP => 'Top P';

  @override
  String get frequencyPenalty => 'Frequency penalty';

  @override
  String get presencePenalty => 'Presence penalty';
}
