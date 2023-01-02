import 'l10n.dart';

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get arbExample1 => 'arb示例1';

  @override
  String arbExample2(String name) {
    return 'arb示例2 $name';
  }

  @override
  String get settings => '设置';

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
