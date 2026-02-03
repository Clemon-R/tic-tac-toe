import 'package:flutter/material.dart';
import 'package:tictactoe/env/themes/basic_theme.dart';
import 'package:tictactoe/ui/components/common/app_button.dart';
import 'package:tictactoe/ui/components/common/app_header.dart';
import 'package:tictactoe/ui/components/common/app_shake.dart';
import 'package:tictactoe/ui/components/layout/app_layout.dart';
import 'package:tictactoe/ui/game/components/game_grid.dart';
import 'package:tictactoe/ui/game/models/game_state_model.dart';

class GameEndView extends StatelessWidget {
  final GameStateModelGameEnd state;
  final VoidCallback onStartGame;
  const GameEndView({
    super.key,
    required this.state,
    required this.onStartGame,
  });

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Stack(
        children: [
          Column(
            children: [
              Spacer(),
              AppHeader(),
              Spacer(),
              GameGrid(
                size: 3,
                gameModel: state.gameModel,
                onTap: (posX, posY) {},
              ),
              Spacer(),
            ],
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Text("GameOver", style: context.appTheme.gameTitleStyle),
                  Text(
                    state.winner == state.gameModel.computerPlayer
                        ? "Looooooser you lost the game"
                        : "You won the game",
                    style: context.appTheme.gameInfoStyle,
                  ),
                  Spacer(),
                  AppShake(
                    child: AppButton(
                      text: "Start Game",
                      onPressed: onStartGame,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
