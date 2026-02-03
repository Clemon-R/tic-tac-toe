import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:tictactoe/data/datasources/i_data_source.dart';
import 'package:tictactoe/data/dtos/chat_gpt/chat_message_dto.dart';
import 'package:tictactoe/data/dtos/chat_gpt/chat_request_dto.dart';
import 'package:tictactoe/data/dtos/chat_gpt/chat_response_dto.dart';
import 'package:tictactoe/data/constants/url_constants.dart';
import 'package:tictactoe/env/environment.dart';

final chatGptDataSourceProvider = Provider<ChatGptDataSource>((ref) {
  return ChatGptDataSource(apiKey: Environment.apiKey);
});

class ChatGptDataSource implements IDataSource<ChatResponseDto, String> {
  final String apiKey;

  ChatGptDataSource({required this.apiKey});

  @override
  Future<ChatResponseDto> call(String text) async {
    final header = {
      UrlConstants.authorizationHeader: "Bearer $apiKey",
      UrlConstants.contentTypeHeader: "application/json",
    };
    final body = ChatRequestDto(
      model: Environment.chatGptModel,
      messages: [ChatMessageDto(role: "user", content: text)],
    );
    try {
      final client = http.Client();
      await Future.delayed(const Duration(seconds: 4));
      final response = await client
          .post(
            Uri.parse(UrlConstants.chatGptApi),
            headers: header,
            body: body.toJson(),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode != HttpStatus.ok) {
        throw Exception("Failed to get response from ChatGPT");
      }
      final dto = ChatResponseDto.fromJson(response.body);
      return dto;
    } catch (ex) {
      throw Exception("Failed to get response from ChatGPT: $ex");
    }
  }
}
