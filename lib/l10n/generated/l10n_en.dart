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
}
