import 'package:flutter/material.dart';
import 'package:tictactoe/env/themes/basic_theme.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("MORPION", style: context.appTheme.gameTitleStyle);
  }
}
