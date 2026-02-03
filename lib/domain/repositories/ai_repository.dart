import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/data/datasources/chat_gpt_data_source.dart';
import 'package:tictactoe/data/repositories/chat_gpt_repository.dart';
import 'package:tictactoe/domain/game/models/game_model.dart';
import 'package:tictactoe/domain/repositories/i_repository.dart';

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return ChatGptRepository(
    chatGptDataSource: ref.read(chatGptDataSourceProvider),
  );
}, dependencies: [chatGptDataSourceProvider]);

abstract class AiRepository implements IRepository {
  Future<Offset> getAiMove(GameModel gameModel);
}
