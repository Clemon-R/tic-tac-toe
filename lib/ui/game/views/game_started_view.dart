import 'package:flutter/material.dart';
import 'package:tictactoe/ui/components/common/app_header.dart';
import 'package:tictactoe/ui/components/layout/app_layout.dart';
import 'package:tictactoe/ui/game/components/game_grid.dart';
import 'package:tictactoe/ui/game/models/game_state_model.dart';

class GameStartedView extends StatelessWidget {
  final GameStateModelGameStarted state;
  const GameStartedView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Column(
        children: [
          AppHeader(),
          Spacer(),
          GameGrid(
            size: 3,
            gameModel: state.gameModel,
            onTap: (posX, posY) {
              print("posX: $posX, posY: $posY");
            },
          ),
          Spacer(),
        ],
      ),
    );
  }
}
