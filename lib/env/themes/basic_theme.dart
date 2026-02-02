import 'package:flutter/material.dart';

class BasicTheme extends ThemeExtension<BasicTheme> {
  Color get titleColor => Colors.black;

  TextStyle get gameTitleStyle =>
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: titleColor);

  @override
  ThemeExtension<BasicTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<BasicTheme> lerp(
    covariant ThemeExtension<BasicTheme>? other,
    double t,
  ) {
    return this;
  }
}

extension BasicThemeExtension on ThemeData {
  BasicTheme get appTheme => extension<BasicTheme>()!;
}

extension BuildContextExtension on BuildContext {
  BasicTheme get appTheme => Theme.of(this).appTheme;
}
