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
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    final gameService = ref.read(gameServiceProvider);
    state = GameStateModelGameStarted(gameModel: gameService.createNewGame());
  }
}
