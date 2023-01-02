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
}
