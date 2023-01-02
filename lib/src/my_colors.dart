import 'package:flutter/material.dart';

@immutable
class MyColors extends ThemeExtension<MyColors> {
  static MyColors light = MyColors(
    promptBackgroundColor: Colors.white,
    completionBackgroundColor: Colors.grey.shade200,
  );
  static const dark = MyColors(
    promptBackgroundColor: Colors.black45,
    completionBackgroundColor: Colors.black38,
  );

  const MyColors({
    required this.promptBackgroundColor,
    required this.completionBackgroundColor,
  });

  final Color? promptBackgroundColor;
  final Color? completionBackgroundColor;

  @override
  MyColors copyWith({
    Color? promptBackgroundColor,
    Color? completionBackgroundColor,
  }) {
    return MyColors(
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
      promptBackgroundColor: Color.lerp(promptBackgroundColor, other.promptBackgroundColor, t),
      completionBackgroundColor: Color.lerp(completionBackgroundColor, other.completionBackgroundColor, t),
    );
  }
}
