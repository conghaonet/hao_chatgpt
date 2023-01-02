// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModelsEntity _$ModelsEntityFromJson(Map<String, dynamic> json) => ModelsEntity(
      json['object'] as String,
      (json['data'] as List<dynamic>)
          .map((e) => ModelEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ModelsEntityToJson(ModelsEntity instance) =>
    <String, dynamic>{
      'object': instance.object,
      'data': instance.models.map((e) => e.toJson()).toList(),
    };

ModelEntity _$ModelEntityFromJson(Map<String, dynamic> json) => ModelEntity(
      json['id'] as String,
      json['object'] as String,
      json['created'] as int,
      json['owned_by'] as String,
      (json['permission'] as List<dynamic>)
          .map((e) => ModelPermissionEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['root'] as String,
      json['parent'],
    );

Map<String, dynamic> _$ModelEntityToJson(ModelEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'owned_by': instance.ownedBy,
      'permission': instance.permissions.map((e) => e.toJson()).toList(),
      'root': instance.root,
      'parent': instance.parent,
    };

ModelPermissionEntity _$ModelPermissionEntityFromJson(
        Map<String, dynamic> json) =>
    ModelPermissionEntity(
      json['id'] as String,
      json['object'] as String,
      json['created'] as int,
      json['allow_create_engine'] as bool,
      json['allow_sampling'] as bool,
      json['allow_logprobs'] as bool,
      json['allow_search_indices'] as bool,
      json['allow_view'] as bool,
      json['allow_fine_tuning'] as bool,
      json['organization'] as String?,
      json['group'],
      json['is_blocking'] as bool,
    );

Map<String, dynamic> _$ModelPermissionEntityToJson(
        ModelPermissionEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'created': instance.created,
      'allow_create_engine': instance.allowCreateEngine,
      'allow_sampling': instance.allowSampling,
      'allow_logprobs': instance.allowLogprobs,
      'allow_search_indices': instance.allowSearchIndices,
      'allow_view': instance.allowView,
      'allow_fine_tuning': instance.allowFineTuning,
      'organization': instance.organization,
      'group': instance.group,
      'is_blocking': instance.isBlocking,
    };
