import 'package:flutter/material.dart';

@immutable
class MyColors extends ThemeExtension<MyColors> {
  static MyColors light = MyColors(
    systemNavigationBarColor: Colors.white,
    completionBackgroundColor: Colors.grey.shade200,
  );
  static const dark = MyColors(
    systemNavigationBarColor: Colors.black,
    completionBackgroundColor: Colors.black54,
  );

  const MyColors({
    required this.systemNavigationBarColor,
    required this.completionBackgroundColor,
  });

  final Color? systemNavigationBarColor;
  final Color? completionBackgroundColor;

  @override
  MyColors copyWith({
    Color? systemNavigationBarColor,
    Color? completionBackgroundColor,
  }) {
    return MyColors(
      systemNavigationBarColor: systemNavigationBarColor,
      completionBackgroundColor: completionBackgroundColor,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      systemNavigationBarColor: Color.lerp(
          systemNavigationBarColor, other.systemNavigationBarColor, t),
      completionBackgroundColor: Color.lerp(
          completionBackgroundColor, other.completionBackgroundColor, t),
    );
  }
}
