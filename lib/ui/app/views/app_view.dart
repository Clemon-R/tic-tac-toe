import 'package:flutter/material.dart';
import 'package:tictactoe/env/themes/basic_theme.dart';
import 'package:tictactoe/ui/game/views/game_view.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, extensions: [BasicTheme()]),
      home: GameView(),
    );
  }
}
