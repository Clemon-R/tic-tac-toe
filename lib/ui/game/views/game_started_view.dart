import 'package:flutter/material.dart';
import 'package:tictactoe/env/themes/basic_theme.dart';
import 'package:tictactoe/ui/components/common/app_header.dart';
import 'package:tictactoe/ui/components/layout/app_layout.dart';
import 'package:tictactoe/ui/game/components/game_grid.dart';
import 'package:tictactoe/ui/game/models/game_state_model.dart';

class GameStartedView extends StatelessWidget {
  final GameStateModelGameStarted state;
  final void Function(int posX, int posY) onSelectCell;
  const GameStartedView({
    super.key,
    required this.state,
    required this.onSelectCell,
  });

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      child: Column(
        children: [
          Spacer(),
          AppHeader(),
          Spacer(),
          _buildGameInfo(context),
          GameGrid(size: 3, gameModel: state.gameModel, onTap: onSelectCell),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildGameInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.appTheme.horizontalPadding,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
        borderRadius: BorderRadius.circular(context.appTheme.radius.x),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: context.appTheme.horizontalPadding,
        vertical: context.appTheme.horizontalPadding,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "You are the ${state.gameModel.humanPlayer.unitType.name}",
            style: context.appTheme.gameInfoStyle,
          ),
          Text(
            state.turn == state.gameModel.humanPlayer
                ? "It's your turn"
                : "It's the computer's turn",
            style: context.appTheme.gameInfoStyle,
          ),
        ],
      ),
    );
  }
}
