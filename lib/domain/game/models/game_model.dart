import 'dart:ui';

import 'package:tictactoe/domain/game/enums/unit_type_enum.dart';
import 'package:tictactoe/domain/game/models/player_model.dart';
import 'package:tictactoe/env/environment.dart';

class GameModel {
  final PlayerModel humanPlayer;
  final PlayerModel computerPlayer;
  final Map<Offset, PlayerModel> unitPositions;

  GameModel({
    required this.humanPlayer,
    required this.computerPlayer,
    required this.unitPositions,
  });

  String toComputerMap() {
    String map = "";
    for (
      var i = 0;
      i < Environment.gameGridSize * Environment.gameGridSize;
      i++
    ) {
      final isNewLine = i != 0 && i % Environment.gameGridSize == 0;
      if (isNewLine) {
        map += "\n";
      }
      final unit =
          unitPositions[Offset(
                (i % Environment.gameGridSize).toDouble(),
                (i ~/ Environment.gameGridSize).toDouble(),
              )]
              ?.unitType;
      switch (unit) {
        case UnitTypeEnum.cross:
          map += "X";
          break;
        case UnitTypeEnum.circle:
          map += "O";
          break;
        default:
          map += "#";
          break;
      }
    }
    return map;
  }
}
