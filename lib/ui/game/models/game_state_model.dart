// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tictactoe/domain/game/models/game_model.dart';
import 'package:tictactoe/domain/game/models/player_model.dart';
import 'package:tictactoe/ui/game/enums/game_message_enum.dart';

abstract class GameStateModel {}

final class GameStateModelInitial extends GameStateModel {}

class GameStateModelGameStarted extends GameStateModel {
  final GameModel gameModel;
  final PlayerModel turn;
  final GameMessageEnum message;

  GameStateModelGameStarted({
    required this.gameModel,
    required this.turn,
    required this.message,
  });

  GameStateModelGameStarted copyWith({
    GameModel? gameModel,
    PlayerModel? turn,
    GameMessageEnum? message,
  }) {
    return GameStateModelGameStarted(
      gameModel: gameModel ?? this.gameModel,
      turn: turn ?? this.turn,
      message: message ?? this.message,
    );
  }
}

class GameStateModelGameEnd extends GameStateModel {
  final GameModel gameModel;
  final PlayerModel? winner;

  GameStateModelGameEnd({required this.gameModel, required this.winner});
}
