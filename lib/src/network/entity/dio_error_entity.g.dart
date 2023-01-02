// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_error_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DioErrorEntity _$DioErrorEntityFromJson(Map<String, dynamic> json) =>
    DioErrorEntity(
      error: json['error'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$DioErrorEntityToJson(DioErrorEntity instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'type': instance.type,
      'code': instance.code,
    };
