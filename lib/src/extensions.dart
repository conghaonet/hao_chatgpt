import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

extension DoubleExt on double {
  String toStringAsFixedNoRound(int fractionDigits, {bool isTight = false}) {
    String str = toString();
    String parsedStr = "0";
    if(str.length <= 2+fractionDigits) {
      parsedStr = toStringAsFixed(fractionDigits);
    } else {
      parsedStr = double.parse(str.substring(0, 4)).toStringAsFixed(fractionDigits);
    }
    if(fractionDigits > 1 && parsedStr.endsWith('0')) {
      return parsedStr.substring(0, parsedStr.length -1);
    } else {
      return parsedStr;
    }
  }
}

String getMaskedApiKey(String keyValue) {
  return keyValue.length > 11
      ? '${keyValue.substring(0,7)}******${keyValue.substring(keyValue.length - 4, keyValue.length)}'
      : keyValue;

}

void setSystemNavigationBarColor(ThemeMode themeMode) {
  if (Platform.isAndroid) {
    Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    if(themeMode == ThemeMode.dark) {
      brightness = Brightness.dark;
    } else if(themeMode == ThemeMode.light) {
      brightness = Brightness.light;
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: brightness == Brightness.dark ? Colors.black : Colors.white,
    ));
  }
}