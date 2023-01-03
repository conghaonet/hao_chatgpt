import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/constants.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:hao_chatgpt/src/network/entity/openai/completions_entity.dart';
import 'package:hao_chatgpt/src/network/entity/openai/completions_query_entity.dart';
import 'package:hao_chatgpt/src/network/entity/openai/model_entity.dart';
import 'package:hao_chatgpt/src/network/openai_service.dart';
import 'package:flutter_test/flutter_test.dart';
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
  io.HttpOverrides.global  = null;
  await appManager.init();
  final logger = Logger();

  test('/models', () async {
    ModelsEntity entity = await openaiService.getModels();
    logger.i(entity.toJson());
  });
  test('/model', () async {
    ModelEntity modelEntity = await openaiService.getModel(modelId: Constants.gpt3ModelDavinci003);
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
    } on DioError catch(e) {
      logger.e(e.toEioErrorEntity.toJson());
    } on Exception catch(e) {
      logger.e(e.toEioErrorEntity.toString());
    }
  });
}