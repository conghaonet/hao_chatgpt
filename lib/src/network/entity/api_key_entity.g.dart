// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIKeyEntity _$APIKeyEntityFromJson(Map<String, dynamic> json) => APIKeyEntity(
      json['key'] as String,
      DateTime.parse(json['createdTime'] as String),
    );

Map<String, dynamic> _$APIKeyEntityToJson(APIKeyEntity instance) =>
    <String, dynamic>{
      'key': instance.key,
      'createdTime': instance.createdTime.toIso8601String(),
    };
