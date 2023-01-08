import 'package:json_annotation/json_annotation.dart';

part 'model_entity.g.dart';

/// 一次性代码生成：flutter pub run build_runner build --delete-conflicting-outputs
/// 持续生成代码（监听器）：flutter pub run build_runner watch
/// 这个标注是告诉生成器，这个类是需要生成Model类的，[参考链接](https://flutter.cn/docs/development/data-and-backend/json)
/// explicitToJson：为嵌套类 (Nested Classes) 生成代码

@JsonSerializable(explicitToJson: true)
class ModelsEntity {
  final String object;
  @JsonKey(name: 'data')
  final List<ModelEntity> models;

  ModelsEntity(this.object, this.models);

  factory ModelsEntity.fromJson(Map<String, dynamic> json) =>
      _$ModelsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ModelsEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ModelEntity {
  final String id;
  final String object;
  final int created;
  @JsonKey(name: "owned_by")
  final String ownedBy;
  @JsonKey(name: "permission")
  final List<ModelPermissionEntity> permissions;
  final String root;
  final dynamic parent;

  ModelEntity(this.id, this.object, this.created, this.ownedBy,
      this.permissions, this.root, this.parent);

  factory ModelEntity.fromJson(Map<String, dynamic> json) =>
      _$ModelEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ModelEntityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ModelPermissionEntity {
  final String id;
  final String object;
  final int created;
  @JsonKey(name: "allow_create_engine")
  final bool allowCreateEngine;
  @JsonKey(name: "allow_sampling")
  final bool allowSampling;
  @JsonKey(name: "allow_logprobs")
  final bool allowLogprobs;
  @JsonKey(name: "allow_search_indices")
  final bool allowSearchIndices;
  @JsonKey(name: "allow_view")
  final bool allowView;
  @JsonKey(name: "allow_fine_tuning")
  final bool allowFineTuning;
  final String? organization;
  final dynamic group;
  @JsonKey(name: "is_blocking")
  final bool isBlocking;

  ModelPermissionEntity(
      this.id,
      this.object,
      this.created,
      this.allowCreateEngine,
      this.allowSampling,
      this.allowLogprobs,
      this.allowSearchIndices,
      this.allowView,
      this.allowFineTuning,
      this.organization,
      this.group,
      this.isBlocking);

  factory ModelPermissionEntity.fromJson(Map<String, dynamic> json) =>
      _$ModelPermissionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ModelPermissionEntityToJson(this);
}
