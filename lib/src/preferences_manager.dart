import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'extensions.dart';
import 'network/entity/openai/completions_query_entity.dart';

class PreferencesManager {
  PreferencesManager._internal();
  static final PreferencesManager _preferencesManager = PreferencesManager._internal();
  factory PreferencesManager() => _preferencesManager;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  late SharedPreferences _preferences;
  SharedPreferences get preferences => _preferences;

  Future<void> init() async {
    if (!_isInitialized) {
      _preferences = await SharedPreferences.getInstance();
    }
    _isInitialized = true;
  }

  ThemeMode get themeMode {
    String? mode = _preferences.getString(SharedPreferencesKey.themeMode);
    if(mode.isNotBlank) {
      if(mode == ThemeMode.light.name) {
        return ThemeMode.light;
      } else if(mode == ThemeMode.dark.name) {
        return ThemeMode.dark;
      }
    }
    return ThemeMode.system;
  }
  Future<bool> setThemeMode(ThemeMode value) => _preferences.setString(SharedPreferencesKey.themeMode, value.name);

  Locale? get locale {
    String? strLocale = _preferences.getString(SharedPreferencesKey.locale);
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
  Future<bool> setLocale(Locale? locale) => _preferences.setString(SharedPreferencesKey.locale, locale?.toString() ?? '');

  String? get apiKey => _preferences.getString(SharedPreferencesKey.apiKey);
  Future<bool> setApiKey(String value) => _preferences.setString(SharedPreferencesKey.apiKey, value);

  double? get temperature => _preferences.getDouble(SharedPreferencesKey.temperature);
  Future<bool> setTemperature(double value) => _preferences.setDouble(SharedPreferencesKey.temperature, value);

  int? get maxTokens => _preferences.getInt(SharedPreferencesKey.maxTokens);
  Future<bool> setMaxTokens(int value) => _preferences.setInt(SharedPreferencesKey.maxTokens, value);

  CompletionsQueryEntity? get gpt3GenerationSettings {
    String? value = _preferences.getString(SharedPreferencesKey.gpt3GenerationSettings);
    if(value.isNotBlank) {
      try {
        dynamic jsonMap = jsonDecode(value!);
        return CompletionsQueryEntity.fromJson(jsonMap);
      } catch(e) {
        return null;
      }
    } else {
      return null;
    }
  }
  Future<bool> setGpt3GenerationSettings(CompletionsQueryEntity entity) {
    return _preferences.setString(SharedPreferencesKey.gpt3GenerationSettings, jsonEncode(entity));
  }
}

class SharedPreferencesKey {
  static const themeMode = 'theme_mode';
  static const locale = 'locale';
  static const apiKey = 'api_key';
  static const temperature = 'temperature';
  static const maxTokens = 'max_tokens';
  static const gpt3GenerationSettings = 'gpt3_generation_settings';
}

PreferencesManager appPref = PreferencesManager();
