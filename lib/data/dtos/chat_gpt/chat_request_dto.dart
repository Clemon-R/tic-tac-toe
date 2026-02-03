// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:tictactoe/data/dtos/chat_gpt/chat_message_dto.dart';

class ChatRequestDto {
  final String model;
  final List<ChatMessageDto> messages;
  ChatRequestDto({required this.model, required this.messages});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatRequestDto.fromMap(Map<String, dynamic> map) {
    return ChatRequestDto(
      model: map['model'] as String,
      messages: List<ChatMessageDto>.from(
        (map['messages'] as List<int>).map<ChatMessageDto>(
          (x) => ChatMessageDto.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatRequestDto.fromJson(String source) =>
      ChatRequestDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
