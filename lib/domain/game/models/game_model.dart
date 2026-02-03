import 'dart:ui';

import 'package:tictactoe/domain/game/models/player_model.dart';

class GameModel {
  final PlayerModel humanPlayer;
  final PlayerModel computerPlayer;
  final Map<Offset, PlayerModel> unitPositions;

  GameModel({
    required this.humanPlayer,
    required this.computerPlayer,
    required this.unitPositions,
  });
}
