import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChatMessageDto {
  final String role;
  final String content;
  ChatMessageDto({
    required this.role,
    required this.content,
  });

  ChatMessageDto copyWith({
    String? role,
    String? content,
  }) {
    return ChatMessageDto(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'content': content,
    };
  }

  factory ChatMessageDto.fromMap(Map<String, dynamic> map) {
    return ChatMessageDto(
      role: map['role'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessageDto.fromJson(String source) =>
      ChatMessageDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
