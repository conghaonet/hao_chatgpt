import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class AppManager {
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;
  String? _openaiApiKey;

  String? get openaiApiKey => _openaiApiKey;

  AppManager._internal();

  static final AppManager _appManager = AppManager._internal();

  factory AppManager() => _appManager;

  Future<void> init() async {
    if (!_isInitialized) {
      await _loadOpenaiKeys();
    }
    _isInitialized = true;
  }

  Future<void> _loadOpenaiKeys() async {
    String str = await rootBundle.loadString('openai.yaml');
    var doc = loadYaml(str);
    _openaiApiKey = doc['openai_api_key'];
  }
}

final AppManager appManager = AppManager();
