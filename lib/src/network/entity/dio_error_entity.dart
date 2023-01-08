import 'package:json_annotation/json_annotation.dart';

part 'dio_error_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class DioErrorEntity {
  final String? error;
  final String? message;
  final String? type;
  final String? code;

  DioErrorEntity({this.error, this.message, this.type, this.code});

  factory DioErrorEntity.fromJson(Map<String, dynamic> json) =>
      _$DioErrorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DioErrorEntityToJson(this);
}
