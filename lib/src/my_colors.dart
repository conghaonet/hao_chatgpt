import 'package:flutter/material.dart';

@immutable
class MyColors extends ThemeExtension<MyColors> {
  static MyColors light = MyColors(
    systemNavigationBarColor: Colors.white,
    promptBackgroundColor: Colors.white,
    completionBackgroundColor: Colors.grey.shade200,
  );
  static const dark = MyColors(
    systemNavigationBarColor: Colors.black,
    promptBackgroundColor: Colors.black45,
    completionBackgroundColor: Colors.black26,
  );

  const MyColors({
    required this.systemNavigationBarColor,
    required this.promptBackgroundColor,
    required this.completionBackgroundColor,
  });

  final Color? systemNavigationBarColor;
  final Color? promptBackgroundColor;
  final Color? completionBackgroundColor;

  @override
  MyColors copyWith({
    Color? systemNavigationBarColor,
    Color? promptBackgroundColor,
    Color? completionBackgroundColor,
  }) {
    return MyColors(
      systemNavigationBarColor: systemNavigationBarColor,
      promptBackgroundColor: promptBackgroundColor,
      completionBackgroundColor: completionBackgroundColor,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      systemNavigationBarColor: Color.lerp(systemNavigationBarColor, other.systemNavigationBarColor, t),
      promptBackgroundColor: Color.lerp(promptBackgroundColor, other.promptBackgroundColor, t),
      completionBackgroundColor: Color.lerp(completionBackgroundColor, other.completionBackgroundColor, t),
    );
  }
}
