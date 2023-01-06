import 'package:json_annotation/json_annotation.dart';

part 'api_key_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class APIKeyEntity {
  final String key;
  final DateTime createdTime;

  APIKeyEntity(this.key, this.createdTime);

  factory APIKeyEntity.fromJson(Map<String, dynamic> json) => _$APIKeyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$APIKeyEntityToJson(this);

}