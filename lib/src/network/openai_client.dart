import 'dart:io';

import 'package:hao_chatgpt/src/app_manager.dart';
import 'package:hao_chatgpt/src/extensions.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class OpenaiClient {
  static const baseUrl = "https://api.openai.com/v1";

  /// 'Content-Type: application/json'
  static BaseOptions baseOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: 60000,
    receiveTimeout: 30000,
  );

  late Dio _dio;

  Dio get dio => _dio;

  OpenaiClient._internal() {
    _dio = Dio(baseOptions);
    setProxy("192.168.31.27", 8888);
    _dio.interceptors.add(_OpenaiInterceptor());
  }

  static final OpenaiClient _client = OpenaiClient._internal();

  factory OpenaiClient() => _client;

  void setProxy(String proxyServer, int port) {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.findProxy = (uri) {
        return "PROXY $proxyServer:$port";
      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
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
