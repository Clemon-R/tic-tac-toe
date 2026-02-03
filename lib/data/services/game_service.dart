import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/domain/game/enums/unit_type_enum.dart';
import 'package:tictactoe/domain/game/models/game_model.dart';
import 'package:tictactoe/domain/game/models/player_model.dart';
import 'package:tictactoe/domain/repositories/ai_repository.dart';

final gameServiceProvider = Provider<GameService>((ref) {
  return GameService(aiRepository: ref.read(aiRepositoryProvider));
}, dependencies: [aiRepositoryProvider]);

class GameService {
  final AiRepository aiRepository;

  GameService({required this.aiRepository});

  GameModel? _currentGame;

  bool get isGameStarted => _currentGame != null;
  GameModel get currentGame => _currentGame!;

  GameModel createNewGame() {
    _currentGame = GameModel(
      humanPlayer: PlayerModel(unitType: UnitTypeEnum.cross),
      computerPlayer: PlayerModel(unitType: UnitTypeEnum.circle),
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
}
