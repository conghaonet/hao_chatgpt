import 'package:hao_chatgpt/src/network/entity/dio_error_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

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

extension SharedPreferencesExt on SharedPreferences {
  ThemeMode get themeMode {
    String? mode = getString(SharedPreferencesKey.themeMode);
    if(mode.isNotBlank) {
      if(mode == ThemeMode.light.name) {
        return ThemeMode.light;
      } else if(mode == ThemeMode.dark.name) {
        return ThemeMode.dark;
      }
    }
    return ThemeMode.system;
  }
  Future<bool> setThemeMode(ThemeMode value) => setString(SharedPreferencesKey.themeMode, value.name);

  Locale? get locale {
    String? strLocale = getString(SharedPreferencesKey.locale);
    if(strLocale.isNotBlank) {
      if(strLocale!.contains('_')) {
        var localeArray = strLocale.split('_');
        return Locale(localeArray[0], localeArray[1]);
      } else {
        return Locale(strLocale);
      }
    } else {
      return null;
    }
  }
  Future<bool> setLocale(Locale? locale) => setString(SharedPreferencesKey.locale, locale?.toString() ?? '');

  String? get apiKey => getString(SharedPreferencesKey.apiKey);
  Future<bool> setApiKey(String value) => setString(SharedPreferencesKey.apiKey, value);

  double? get temperature => getDouble(SharedPreferencesKey.temperature);
  Future<bool> setTemperature(double value) => setDouble(SharedPreferencesKey.temperature, value);

  int? get maxTokens => getInt(SharedPreferencesKey.maxTokens);
  Future<bool> setMaxTokens(int value) => setInt(SharedPreferencesKey.maxTokens, value);


}
