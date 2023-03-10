import 'package:json_annotation/json_annotation.dart';


part 'chat_message_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatMessageEntity {
  final String role;
  final String content;
  ChatMessageEntity({required this.role, required this.content});

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageEntityToJson(this);
}
