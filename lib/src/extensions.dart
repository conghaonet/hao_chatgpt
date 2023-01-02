import 'package:hao_chatgpt/src/network/entity/dio_error_entity.dart';
import 'package:dio/dio.dart';

extension StringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotBlank => this != null && this!.trim().isNotEmpty;
}

extension DioErrorExt on DioError {
  DioErrorEntity get toEioErrorEntity {
    Map<String, dynamic> error = {'error': this.error};
    Map<String, dynamic>? dataError = response?.data['error'];
    if (dataError != null) {
      error.addAll(dataError);
    }
    return DioErrorEntity.fromJson(error);
  }
}

extension ExceptionExt on Exception {
  DioErrorEntity get toEioErrorEntity {
    var msg = toString();
    if (msg.startsWith('Exception: ')) {
      msg = msg.replaceFirst('Exception: ', '');
    }
    Map<String, dynamic> error = {'message': msg};
    return DioErrorEntity.fromJson(error);
  }
}
