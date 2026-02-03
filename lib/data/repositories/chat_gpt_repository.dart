import 'dart:ui';

import 'package:tictactoe/data/datasources/chat_gpt_data_source.dart';
import 'package:tictactoe/domain/game/models/game_model.dart';
import 'package:tictactoe/domain/repositories/ai_repository.dart';
import 'package:tictactoe/env/environment.dart';

class ChatGptRepository implements AiRepository {
  final ChatGptDataSource chatGptDataSource;

  ChatGptRepository({required this.chatGptDataSource});

  @override
  Future<Offset> getAiMove(GameModel currentGame) async {
    final prompt = _getPromptComputerMove(
      currentGame,
      currentGame.toComputerMap(),
    );
    final response = await chatGptDataSource(prompt);
    final responseText = response.choices.first.message.content;
    final newComputerMove = _getComputerMoveFromMap(
      currentGame.toComputerMap(),
      responseText,
    );
    final isInvalidMove = newComputerMove == null;
    if (isInvalidMove) {
      throw Exception("Invalid move");
    }
    return newComputerMove;
  }

  Offset? _getComputerMoveFromMap(String oldMap, String newMap) {
    oldMap = oldMap.replaceAll("\n", "");
    newMap = newMap.replaceAll("\n", "");
    for (var i = 0; i < oldMap.length; i++) {
      final newChar = newMap[i];
      final oldChar = oldMap[i];
      final isSame = newChar == oldChar;
      if (isSame) {
        continue;
      }
      final x = i % Environment.gameGridSize;
      final y = i ~/ Environment.gameGridSize;
      return Offset(x.toDouble(), y.toDouble());
    }
    return null;
  }

  String _getPromptComputerMove(GameModel gameModel, String map) {
    return "play with me tic tac toe, simple reply with the same pattern.\nyou are the ${gameModel.computerPlayer.unitType.name} i\"m the ${gameModel.humanPlayer.unitType.name}\n\n$map";
  }
}
