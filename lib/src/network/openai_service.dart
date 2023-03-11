import 'package:hao_chatgpt/src/network/entity/openai/chat_entity.dart';
import 'package:hao_chatgpt/src/network/entity/openai/completions_entity.dart';
import 'package:hao_chatgpt/src/network/entity/openai/completions_query_entity.dart';
import 'package:hao_chatgpt/src/network/entity/openai/model_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'entity/openai/chat_query_entity.dart';
import 'openai_client.dart';

part 'openai_service.g.dart';

/// flutter pub run build_runner build --delete-conflicting-outputs
@RestApi()
abstract class OpenaiService {
  factory OpenaiService(Dio dio, {String? baseUrl}) = _OpenaiService;

  @GET('/models')
  Future<ModelsEntity> getModels();

  @GET('/models/{model}')
  Future<ModelEntity> getModel({@Path("model") required String modelId});

  @POST('/completions')
  Future<CompletionsEntity> getCompletions(
      @Body() CompletionsQueryEntity query);

  @POST('/chat/completions')
  Future<ChatEntity> getChatCompletions(
      @Body() ChatQueryEntity query);
}

OpenaiService openaiService = OpenaiService(openaiClient.dio);
