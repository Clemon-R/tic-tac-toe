import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/ui/components/common/app_fade.dart';
import 'package:tictactoe/ui/game/models/game_state_model.dart';
import 'package:tictactoe/ui/game/providers/game_state_provider.dart';
import 'package:tictactoe/ui/game/views/game_initial_view.dart';
import 'package:tictactoe/ui/game/views/game_started_view.dart';

// ignore: must_be_immutable
class GameView extends ConsumerWidget {
  final GlobalKey _gameInitialViewKey = GlobalKey();
  GameStateModel? _previousGameState;

  GameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final shouldTranslate =
        _previousGameState != null &&
        _previousGameState.runtimeType != gameState.runtimeType;
    if (shouldTranslate) {
      final previousGameView = _buildGameView(
        context,
        ref,
        _previousGameState!,
      );
      final newGameView = _buildGameView(context, ref, gameState);
      _previousGameState = gameState;
      return AppFade(originalWidget: previousGameView, newWidget: newGameView);
    }
    _previousGameState = gameState;
    return _buildGameView(context, ref, gameState);
  }

  Widget _buildGameView(
    BuildContext context,
    WidgetRef ref,
    GameStateModel gameState,
  ) {
    return switch (gameState.runtimeType) {
      const (GameStateModelInitial) => GameInitialView(
        key: _gameInitialViewKey,
        state: gameState as GameStateModelInitial,
        onStartGame: () {
          ref.read(gameStateProvider.notifier).startGame();
        },
      ),
      const (GameStateModelGameStarted) => GameStartedView(
        state: gameState as GameStateModelGameStarted,
        onSelectCell: (posX, posY) {
          ref.read(gameStateProvider.notifier).selectCell(posX, posY);
        },
      ),
      _ => Container(),
    };
  }
}
