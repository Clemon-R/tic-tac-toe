import 'package:flutter/material.dart';
import 'package:tictactoe/env/themes/basic_theme.dart';
import 'package:tictactoe/ui/components/layout/app_layout.dart';
import 'package:tictactoe/ui/game/components/game_grid.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Column(
        children: [
          Text("MORPION", style: context.appTheme.gameTitleStyle),
          GameGrid(),
        ],
      ),
    );
  }
}
