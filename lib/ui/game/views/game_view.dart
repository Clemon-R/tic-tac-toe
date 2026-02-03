import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/ui/components/common/app_fade.dart';
import 'package:tictactoe/ui/game/enums/game_message_enum.dart';
import 'package:tictactoe/ui/game/models/game_state_model.dart';
import 'package:tictactoe/ui/game/providers/game_state_provider.dart';
import 'package:tictactoe/ui/game/views/game_end_view.dart';
import 'package:tictactoe/ui/game/views/game_initial_view.dart';
import 'package:tictactoe/ui/game/views/game_started_view.dart';

// ignore: must_be_immutable
class GameView extends ConsumerWidget {
  final GlobalKey _gameInitialViewKey = GlobalKey();
  final GlobalKey _gameStartedViewKey = GlobalKey();
  final GlobalKey _gameEndViewKey = GlobalKey();
  GameStateModel? _previousGameState;

  GameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    ref.listen(gameStateProvider, (previous, next) {
      if (next is! GameStateModelGameStarted) return;
      _showMessage(context, next);
    });

    return _buildContent(context, ref, gameState);
  }

  void _showMessage(BuildContext context, GameStateModelGameStarted gameState) {
    final isMessageAvailable = gameState.message != GameMessageEnum.none;
    if (!isMessageAvailable) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(gameState.message.content)));
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    GameStateModel gameState,
  ) {
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
        key: _gameStartedViewKey,
        state: gameState as GameStateModelGameStarted,
        onSelectCell: (posX, posY) {
          ref.read(gameStateProvider.notifier).selectCell(posX, posY);
        },
      ),
      const (GameStateModelGameEnd) => GameEndView(
        key: _gameEndViewKey,
        state: gameState as GameStateModelGameEnd,
        onStartGame: () {
          ref.read(gameStateProvider.notifier).startGame();
        },
      ),
      _ => Container(),
    };
  }
}
