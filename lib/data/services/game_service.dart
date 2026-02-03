import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/domain/game/enums/unit_type_enum.dart';
import 'package:tictactoe/domain/game/models/game_model.dart';
import 'package:tictactoe/domain/game/models/player_model.dart';
import 'package:tictactoe/domain/repositories/ai_repository.dart';
import 'package:tictactoe/env/environment.dart';

final gameServiceProvider = Provider<GameService>((ref) {
  return GameService(aiRepository: ref.read(aiRepositoryProvider));
}, dependencies: [aiRepositoryProvider]);

class GameService {
  final AiRepository aiRepository;

  GameService({required this.aiRepository});

  GameModel? _currentGame;

  bool get isGameStarted => _currentGame != null;
  GameModel get currentGame => _currentGame!;

  GameModel createNewGame(UnitTypeEnum humanUnitType) {
    final computerUnitType = humanUnitType == UnitTypeEnum.cross
        ? UnitTypeEnum.circle
        : UnitTypeEnum.cross;
    _currentGame = GameModel(
      humanPlayer: PlayerModel(unitType: humanUnitType),
      computerPlayer: PlayerModel(unitType: computerUnitType),
      unitPositions: {},
    );
    return _currentGame!;
  }

  void selectCell(PlayerModel player, double posX, double posY) {
    _currentGame!.unitPositions[Offset(posX.toDouble(), posY.toDouble())] =
        player;
  }

  Future<bool> launchComputerMove() async {
    try {
      final newComputerMove = await aiRepository.getAiMove(currentGame);

      selectCell(
        currentGame.computerPlayer,
        newComputerMove.dx,
        newComputerMove.dy,
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  bool isWon(PlayerModel player) {
    for (final entry in currentGame.unitPositions.entries) {
      final playerModel = entry.value;
      if (playerModel.unitType != player.unitType) {
        continue;
      }
      for (final entry in currentGame.unitPositions.entries) {
        final playerModel = entry.value;
        if (playerModel.unitType != player.unitType) {
          continue;
        }
        final cells = getLongestLineByPlayer(player, entry.key);
        if (cells.length < Environment.gameGridSize) {
          continue;
        }
        print(cells);
        return true;
      }
    }
    return false;
  }

  List<Offset> getLongestLineByPlayer(PlayerModel player, Offset pos) {
    List<Offset> lines = [];
    final dirs = [-1, 0, 1];
    for (final dirX in dirs) {
      for (final dirY in dirs) {
        if (dirX == 0 && dirY == 0) {
          continue;
        }
        final cells = getCellsByDirection(player, pos, dirX, dirY);
        final isLonger = cells.length > lines.length;
        if (isLonger) {
          lines = cells;
        }
      }
    }
    return [pos, ...lines];
  }

  List<Offset> getCellsByDirection(
    PlayerModel player,
    Offset pos,
    int dirX,
    int dirY,
  ) {
    final nextX = pos.dx + dirX;
    final nextY = pos.dy + dirY;
    if (nextX < 0 ||
        nextX >= Environment.gameGridSize ||
        nextY < 0 ||
        nextY >= Environment.gameGridSize) {
      return [];
    }
    final cell = Offset(nextX.toDouble(), nextY.toDouble());
    final cells = <Offset>[];
    final cellPlayer = currentGame.unitPositions[cell];
    final isSamePlayer = cellPlayer?.unitType == player.unitType;
    if (isSamePlayer) {
      cells.add(cell);
      cells.addAll(getCellsByDirection(player, cell, dirX, dirY));
    }
    return cells;
  }
}
