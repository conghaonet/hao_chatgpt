import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hao_chatgpt/src/app_config.dart';
import 'package:yaml/yaml.dart';

class AppManager {
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  String? _innerApiKey;

  String? get innerApiKey => _innerApiKey;

  String? get openaiApiKey => appConfig.apiKey ?? _innerApiKey;

  AppManager._internal();

  static final AppManager _appManager = AppManager._internal();

  factory AppManager() => _appManager;

  Future<void> init() async {
    if (!_isInitialized) {
      await appConfig.init();
      await _loadInnerApiKey();
    }
    _isInitialized = true;
  }

  Future<void> _loadInnerApiKey() async {
    try {
      String str = await rootBundle.loadString('openai.yaml');
      var doc = loadYaml(str);
      _innerApiKey = doc['api_key'];
    } catch (e) {
      debugPrint('openai.yaml not found.');
    }
  }
}

final AppManager appManager = AppManager();
