// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tictactoe/data/dtos/chat_gpt/chat_message_dto.dart';

class ChatChoiceDto {
  final ChatMessageDto message;
  ChatChoiceDto({required this.message});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'message': message.toMap()};
  }

  factory ChatChoiceDto.fromMap(Map<String, dynamic> map) {
    return ChatChoiceDto(
      message: ChatMessageDto.fromMap(map['message'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatChoiceDto.fromJson(String source) =>
      ChatChoiceDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
