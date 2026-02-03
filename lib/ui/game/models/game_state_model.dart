// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tictactoe/domain/game/models/game_model.dart';
import 'package:tictactoe/domain/game/models/player_model.dart';

abstract class GameStateModel {}

final class GameStateModelInitial extends GameStateModel {}

class GameStateModelGameStarted extends GameStateModel {
  final GameModel gameModel;
  final PlayerModel turn;

  GameStateModelGameStarted({required this.gameModel, required this.turn});

  GameStateModelGameStarted copyWith({
    GameModel? gameModel,
    PlayerModel? turn,
  }) {
    return GameStateModelGameStarted(
      gameModel: gameModel ?? this.gameModel,
      turn: turn ?? this.turn,
    );
  }
}
