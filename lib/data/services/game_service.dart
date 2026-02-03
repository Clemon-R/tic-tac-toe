import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/domain/game/enums/unit_type_enum.dart';
import 'package:tictactoe/domain/game/models/game_model.dart';
import 'package:tictactoe/domain/game/models/player_model.dart';

final gameServiceProvider = Provider<GameService>((ref) {
  return GameService();
});

class GameService {
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
}
