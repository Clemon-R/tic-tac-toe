// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tictactoe/data/dtos/chat_gpt/chat_choice_dto.dart';

class ChatResponseDto {
  final List<ChatChoiceDto> choices;
  ChatResponseDto({required this.choices});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'choices': choices.map((x) => x.toMap()).toList()};
  }

  factory ChatResponseDto.fromMap(Map<String, dynamic> map) {
    return ChatResponseDto(
      choices: (map['choices'] as List<dynamic>)
          .map((e) => ChatChoiceDto.fromMap(e))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatResponseDto.fromJson(String source) =>
      ChatResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
