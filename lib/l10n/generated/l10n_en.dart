import 'package:intl/intl.dart' as intl;

import 'l10n.dart';

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get arbExample1 => 'arbExample1';

  @override
  String arbExample2(String name) {
    return 'arbExample2 $name';
  }

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
  String get haoChat => 'HaoChat';

  @override
  String get openAI => 'OpenAI';

  @override
  String get chatGPT => 'ChatGPT';

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
