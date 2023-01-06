// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_key_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiKeyEntity _$ApiKeyEntityFromJson(Map<String, dynamic> json) => ApiKeyEntity(
      json['key'] as String,
      DateTime.parse(json['createdTime'] as String),
    );

Map<String, dynamic> _$ApiKeyEntityToJson(ApiKeyEntity instance) =>
    <String, dynamic>{
      'key': instance.key,
      'createdTime': instance.createdTime.toIso8601String(),
    };
