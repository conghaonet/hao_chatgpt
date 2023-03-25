import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hao_chatgpt/src/network/entity/api_key_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'extensions.dart';
import 'network/entity/openai/chat_query_entity.dart';
import 'network/entity/openai/completions_query_entity.dart';

class AppConfig {
  AppConfig._internal();
  static final AppConfig _preferencesManager =
      AppConfig._internal();
  factory AppConfig() => _preferencesManager;

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
    if (mode.isNotBlank) {
      if (mode == ThemeMode.light.name) {
        return ThemeMode.light;
      } else if (mode == ThemeMode.dark.name) {
        return ThemeMode.dark;
      }
    }
    return ThemeMode.system;
  }

  Future<bool> setThemeMode(ThemeMode? value) {
    if (value == null) {
      return _preferences.remove(SharedPreferencesKey.themeMode);
    } else {
      return _preferences.setString(SharedPreferencesKey.themeMode, value.name);
    }
  }

  Locale? get locale {
    String? strLocale = _preferences.getString(SharedPreferencesKey.locale);
    if (strLocale.isNotBlank) {
      if (strLocale!.contains('_')) {
        var localeArray = strLocale.split('_');
        return Locale(localeArray[0], localeArray[1]);
      } else {
        return Locale(strLocale);
      }
    } else {
      return null;
    }
  }

  Future<bool> setLocale(Locale? locale) {
    if (locale == null) {
      return _preferences.remove(SharedPreferencesKey.locale);
    } else {
      return _preferences.setString(
          SharedPreferencesKey.locale, locale.toString());
    }
  }

  String? get apiKey => _preferences.getString(SharedPreferencesKey.apiKey);
  Future<bool> setApiKey(String? value) {
    if (value.isNotBlank) {
      return _preferences.setString(SharedPreferencesKey.apiKey, value!);
    } else {
      return _preferences.remove(SharedPreferencesKey.apiKey);
    }
  }

  CompletionsQueryEntity? get gpt3GenerationSettings {
    String? value =
        _preferences.getString(SharedPreferencesKey.gpt3GenerationSettings);
    if (value.isNotBlank) {
      try {
        dynamic jsonMap = jsonDecode(value!);
        return CompletionsQueryEntity.fromJson(jsonMap);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> setGpt3GenerationSettings(CompletionsQueryEntity? entity) {
    if (entity == null) {
      return _preferences.remove(SharedPreferencesKey.gpt3GenerationSettings);
    } else {
      return _preferences.setString(
          SharedPreferencesKey.gpt3GenerationSettings, jsonEncode(entity));
    }
  }

  ChatQueryEntity? get gpt35TurboSettings {
    String? value =
    _preferences.getString(SharedPreferencesKey.gpt35TurboSettings);
    if (value.isNotBlank) {
      try {
        dynamic jsonMap = jsonDecode(value!);
        return ChatQueryEntity.fromJson(jsonMap);
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> setGpt35TurboSettings(ChatQueryEntity? entity) {
    if (entity == null) {
      return _preferences.remove(SharedPreferencesKey.gpt35TurboSettings);
    } else {
      return _preferences.setString(
          SharedPreferencesKey.gpt35TurboSettings, jsonEncode(entity));
    }
  }

  List<ApiKeyEntity> get apiKeys {
    String? value = _preferences.getString(SharedPreferencesKey.apiKeys);
    if (value.isNotBlank) {
      List<dynamic> jsonMap = jsonDecode(value!);
      return jsonMap.map((e) => ApiKeyEntity.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<bool> _setApiKeys(List<ApiKeyEntity>? keys) {
    if (keys == null || keys.isEmpty) {
      return _preferences.remove(SharedPreferencesKey.apiKeys);
    } else {
      return _preferences.setString(
          SharedPreferencesKey.apiKeys, jsonEncode(keys));
    }
  }

  Future<bool> addApiKey(ApiKeyEntity keyEntity, {bool isDefault = true}) async {
    bool isOk = true;
    if(isDefault) {
      isOk = await setApiKey(keyEntity.key);
    }
    if(isOk) {
      List<ApiKeyEntity> entities = apiKeys;
      entities.add(keyEntity);
      return _setApiKeys(entities);
    } else {
      return Future(() => false);
    }
  }

  Future<bool> removeApiKey(String apiKey) {
    List<ApiKeyEntity> entities = apiKeys;
    try {
      ApiKeyEntity entity =
          entities.firstWhere((element) => element.key == apiKey);
      entities.remove(entity);
      return _setApiKeys(entities);
    } catch (e) {
      return Future(() => false);
    }
  }

  LogicalKeySet? get shortcutsSend {
    String? keys = _preferences.getString(SharedPreferencesKey.shortcutsSend);
    if(keys.isNullOrEmpty) {
      if(Platform.isWindows || Platform.isLinux || Platform.isFuchsia) {
        return LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.enter);
      } else if(Platform.isMacOS) {
        return LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.enter);
      } else {
        return null;
      }
    } else {
      List<LogicalKeyboardKey> keyboardKeys = keys!.split(',').map((e) => LogicalKeyboardKey(int.parse(e))).toList();
      switch(keyboardKeys.length) {
        case 1:
          return LogicalKeySet(keyboardKeys[0]);
        case 2:
          return LogicalKeySet(keyboardKeys[0], keyboardKeys[1]);
        case 3:
          return LogicalKeySet(keyboardKeys[0], keyboardKeys[1], keyboardKeys[2]);
        case 4:
          return LogicalKeySet(keyboardKeys[0], keyboardKeys[1], keyboardKeys[2], keyboardKeys[3]);
        default:
          return null;
      }
    }
  }

  Future<bool> setShortcutsSend(LogicalKeySet? logicalKeySet) {
    String keys = '';
    if(logicalKeySet != null) {
      for(LogicalKeyboardKey keyboardKey in logicalKeySet.keys) {
        if(keys.isNotEmpty) keys += ',';
        keys += '${keyboardKey.keyId}';
      }
    }
    return _preferences.setString(SharedPreferencesKey.shortcutsSend, keys);
  }

  /// For example: true<|>192.168.3.22<|>7890
  String? get httpProxy => _preferences.getString(SharedPreferencesKey.httpProxy);

  Future<bool> setHttpProxy(bool enabled, String? hostname, int? port) {
    String value = '${enabled.toString()}${Constants.splitTag}';
    if(hostname.isNotBlank) {
      value += hostname!;
    }
    value += Constants.splitTag;
    if(port != null) {
      value += port.toString();
    }
    return _preferences.setString(SharedPreferencesKey.httpProxy, value);
  }

  int get systemPromptLimit => _preferences.getInt(SharedPreferencesKey.systemPromptLimit) ?? Constants.systemPromptLimit;
  Future<bool> setSystemPromptLimit(int? value) {
    if (value != null && value > 0) {
      return _preferences.setInt(SharedPreferencesKey.systemPromptLimit, value);
    } else {
      return _preferences.remove(SharedPreferencesKey.systemPromptLimit);
    }
  }
}

class SharedPreferencesKey {
  static const themeMode = 'theme_mode';
  static const locale = 'locale';
  static const apiKey = 'api_key';
  static const temperature = 'temperature';
  static const maxTokens = 'max_tokens';
  static const gpt3GenerationSettings = 'gpt3_generation_settings';
  static const gpt35TurboSettings = 'gpt35turbo_settings';
  static const apiKeys = 'api_keys';
  static const shortcutsSend = 'shortcuts_send';
  static const httpProxy = 'http_proxy';
  static const systemPromptLimit = 'system_prompt_limit';
}

AppConfig appConfig = AppConfig();
