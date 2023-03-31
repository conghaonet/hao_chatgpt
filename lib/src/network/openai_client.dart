import 'dart:io';

import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hao_chatgpt/src/app_config.dart';

import '../constants.dart';

class OpenaiClient {
  static const baseUrl = "https://api.openai.com/v1";

  /// 'Content-Type: application/json'
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 60000,
  );

  late Dio _dio;

  Dio get dio => _dio;

  OpenaiClient._internal() {
    _dio = Dio(baseOptions);
    _setupProxy();
    _dio.interceptors.add(_OpenaiInterceptor());
  }

  static final OpenaiClient _client = OpenaiClient._internal();

  factory OpenaiClient() => _client;

  void _setupProxy() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.findProxy = (uri) {
        // set multi proxy
        // return "PROXY localhost:8888;PROXY localhost:7777";
        // 设置代理与未设置代理均支持  ‘DIRECT’一定要放在最后
        // return "PROXY localhost:8888;DIRECT";
        String? value = appConfig.httpProxy;
        if(value.isNotBlank) {
          List<String> args = value!.split(Constants.splitTag);
          if(args.length == 3) {
            bool enableProxy = args[0] == true.toString();
            String hostname = args[1];
            int? portNumber = int.tryParse(args[2]);
            if(enableProxy && hostname.isNotBlank && portNumber != null) {
              return "PROXY $hostname:$portNumber";
            }
          }
        }
        // no proxy
        return 'DIRECT';
      };
      // 解决安卓https抓包问题
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return null;
      // you can also create a HttpClient to dio
      // return HttpClient();
    };
  }

}

class _OpenaiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (isOpenaiApiRequest(options)) {
      if (appManager.openaiApiKey.isNotBlank) {
        options.headers['Authorization'] = 'Bearer ${appManager.openaiApiKey}';
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(response.headers.toString());
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(err.requestOptions.toString());
    super.onError(err, handler);
  }

  /// It's a openai api request.
  bool isOpenaiApiRequest(RequestOptions options) =>
      options.path.startsWith('/') && options.baseUrl == OpenaiClient.baseUrl;
}

final OpenaiClient openaiClient = OpenaiClient();
