import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/constants.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/network/entity/api_key_entity.dart';
import 'package:hao_chatgpt/src/network/entity/openai/completions_entity.dart';
import 'package:hao_chatgpt/src/network/entity/openai/completions_query_entity.dart';
import 'package:hao_chatgpt/src/network/entity/openai/model_entity.dart';
import 'package:hao_chatgpt/src/network/openai_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hao_chatgpt/src/app_config.dart';
import 'package:logger/logger.dart';
import 'dart:io' as io;
import 'package:dio/dio.dart';

void main() async {
  /// The implementation of TestWidgetsFlutterBinding.ensureInitialized() seems to install
  /// a mock http client in package:flutter_test/src/_binding_io.dart (see also _http/overrides.dart),
  /// which is probably why you get a different response.
  /// After calling TestWidgetsFlutterBinding.ensureInitialized(), set HttpOverrides.global  = null in dart:io.
  /// https://github.com/flutter/flutter/issues/48050
  TestWidgetsFlutterBinding.ensureInitialized();
  io.HttpOverrides.global = null;
  // await appManager.init();
  final logger = Logger();

  test('/models', () async {
    ModelsEntity entity = await openaiService.getModels();
    logger.i(entity.toJson());
  });
  test('/model', () async {
    ModelEntity modelEntity =
        await openaiService.getModel(modelId: Constants.gpt3ModelDavinci003);
    logger.i(modelEntity.toJson());
  });

  test('/completions', () async {
    // 地球为什么会自转
    // 再具体说说
    var query = CompletionsQueryEntity(
      model: Constants.gpt3ModelDavinci003,
      prompt: '地球为什么会自转',
      maxTokens: 1000,
      temperature: 0.5,
    );
    try {
      CompletionsEntity entity = await openaiService.getCompletions(query);
      logger.i(entity.toJson());
    } on DioError catch (e) {
      logger.e(e.toDioErrorEntity.toJson());
    } on Exception catch (e) {
      logger.e(e.toDioErrorEntity.toString());
    }
  });

  test('parse', () {
    try {
      logger.i(double.tryParse("abc") ?? 'is null');
    } catch (e) {
      logger.e(e);
    }
  });
  test('double format', () {
    var a = 0.456;
    logger.i(a.toStringAsFixed(2));
    logger.i(a.toStringAsExponential(2));
    logger.i(a.toStringAsPrecision(2));
  });

  test('test prefs', () async {
    // appPref._setApiKeys(null);

    // List<APIKeyEntity> entities = List.generate(3, (index) {
    //   return APIKeyEntity('$index$index$index', DateTime.now());
    // });
    // await appPref.setAPIKeys(entities);
    List<ApiKeyEntity> keys = appConfig.apiKeys;
    logger.i(keys.map((e) => e.toJson()));
  });

  test('testReplace', () {
    var str = '\n\n\n\nhow\n are you?';
    var regExp = RegExp(r'^\n+');
    logger.i(regExp.hasMatch(str));
    logger.i(str);
    logger.i(str.replaceAll(regExp, ''));
  });

  test('RegExp', (){
    String input = 'This model\'s maximum context length is 4097 tokens. However, you requested 4141 tokens (3885 in the messages, 256 in the completion). Please reduce the length of the messages or completion.';
    RegExp digits = RegExp(r'\d+ tokens');
    Iterable<Match> matches = digits.allMatches(input);
    for (Match match in matches) {
      print(match.group(0));
    }
  });
}
