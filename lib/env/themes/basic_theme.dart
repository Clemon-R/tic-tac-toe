import 'package:flutter/material.dart';

class BasicTheme extends ThemeExtension<BasicTheme> {
  Color get titleColor => Colors.black;

  Radius get radius => Radius.circular(10);
  double get horizontalPadding => 20;

  TextStyle get gameTitleStyle => TextStyle(
    fontSize: 68,
    fontWeight: FontWeight.bold,
    color: titleColor,
    shadows: [
      Shadow(
        color: Colors.black.withValues(alpha: 0.5),
        offset: Offset(-4, 4),
        blurRadius: 8,
      ),
    ],
  );
  TextStyle get buttonTextStyle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: titleColor);

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
