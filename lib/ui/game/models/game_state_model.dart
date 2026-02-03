import 'package:tictactoe/domain/game/models/game_model.dart';

abstract class GameStateModel {}

final class GameStateModelInitial extends GameStateModel {}

final class GameStateModelGameStarted extends GameStateModel {
  final GameModel gameModel;

  GameStateModelGameStarted({required this.gameModel});
}
