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
  String get openAI => 'OpenAI';

  @override
  String get chatGPT => 'ChatGPT';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System';

  @override
  String get language => 'Language';

  @override
  String get langEnglish => 'English';

  @override
  String get langChinese => 'Chinese';

  @override
  String get settingsReset => 'Reset';
}
