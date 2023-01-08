import 'package:json_annotation/json_annotation.dart';

part 'api_key_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ApiKeyEntity {
  final String key;
  final DateTime createdTime;

  ApiKeyEntity(this.key, this.createdTime);

  factory ApiKeyEntity.fromJson(Map<String, dynamic> json) =>
      _$ApiKeyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ApiKeyEntityToJson(this);
}
