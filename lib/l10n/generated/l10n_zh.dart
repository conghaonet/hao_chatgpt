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
  String get theme => '主题';

  @override
  String get chooseTheme => '选择主题';

  @override
  String get light => '亮色模式';

  @override
  String get dark => '暗色模式';

  @override
  String get systemDefault => '系统默认';

  @override
  String get language => '语言';

  @override
  String get settingsReset => '重置';

  @override
  String get cancel => '取消';

  @override
  String get openAI => 'OpenAI';

  @override
  String get chatGPT => 'ChatGPT';

  @override
  String get langEnglish => 'English';

  @override
  String get langChinese => '简体中文';
}
