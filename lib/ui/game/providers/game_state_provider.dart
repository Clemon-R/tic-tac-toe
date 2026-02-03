// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tictactoe/data/services/game_service.dart';
import 'package:tictactoe/ui/game/models/game_state_model.dart';

part 'game_state_provider.g.dart';

@riverpod
class GameState extends _$GameState {
  @override
  GameStateModel build() {
    return GameStateModelInitial();
  }

  void startGame() {
    final gameService = ref.read(gameServiceProvider);
    final gameModel = gameService.createNewGame();
    final turn = Random().nextBool()
        ? gameService.currentGame.humanPlayer
        : gameService.currentGame.computerPlayer;
    state = GameStateModelGameStarted(gameModel: gameModel, turn: turn);

    _startComputerTurn();
  }

  void selectCell(int posX, int posY) async {
    if (state is! GameStateModelGameStarted) {
      return;
    }
    final currentGameState = state as GameStateModelGameStarted;
    final isHumanTurn =
        currentGameState.turn == currentGameState.gameModel.humanPlayer;
    if (!isHumanTurn) {
      return;
    }
    final gameService = ref.read(gameServiceProvider);
    gameService.selectCell(
      currentGameState.gameModel.humanPlayer,
      posX.toDouble(),
      posY.toDouble(),
    );
    final nextTurn =
        currentGameState.turn == currentGameState.gameModel.humanPlayer
        ? currentGameState.gameModel.computerPlayer
        : currentGameState.gameModel.humanPlayer;
    state = currentGameState.copyWith(
      gameModel: gameService.currentGame,
      turn: nextTurn,
    );

    _startComputerTurn();
  }

  Future<void> _startComputerTurn() async {
    if (state is! GameStateModelGameStarted) {
      return;
    }
    final currentGameState = state as GameStateModelGameStarted;
    final isComputerTurn =
        currentGameState.turn == currentGameState.gameModel.computerPlayer;
    if (!isComputerTurn) {
      return;
    }
    final gameService = ref.read(gameServiceProvider);
    final success = await gameService.launchComputerMove();
    if (!success) {
      return;
    }
    final nextTurn = currentGameState.gameModel.humanPlayer;
    state = currentGameState.copyWith(
      gameModel: gameService.currentGame,
      turn: nextTurn,
    );
  }
}
