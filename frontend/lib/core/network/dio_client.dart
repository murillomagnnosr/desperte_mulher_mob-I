import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../constants/app_constants.dart';

/// Cliente HTTP centralizado (wrapper sobre o Dio).
///
/// Responsável por:
///  - configurar baseUrl/timeouts a partir de [AppConfig];
///  - anexar automaticamente o token JWT (interceptor de request);
///  - logar requisições em ambiente de desenvolvimento;
///  - centralizar o tratamento de 401 (sessão expirada).
///
/// É injetado nos DataSources, que por sua vez são usados pelos Repositories.
class DioClient {
  DioClient({required AppConfig config, required SharedPreferences prefs})
      : _prefs = prefs,
        dio = Dio(
          BaseOptions(
            baseUrl: config.apiBaseUrl,
            connectTimeout:
                const Duration(milliseconds: AppConstants.connectTimeoutMs),
            receiveTimeout:
                const Duration(milliseconds: AppConstants.receiveTimeoutMs),
            contentType: 'application/json',
            responseType: ResponseType.json,
          ),
        ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _prefs.getString(AppConstants.kAccessToken);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          if (e.response?.statusCode == 401) {
            // Sessão expirada: limpa tokens. O redirect do GoRouter
            // levará o usuário ao login na próxima navegação protegida.
            _prefs.remove(AppConstants.kAccessToken);
            _prefs.remove(AppConstants.kRefreshToken);
          }
          return handler.next(e);
        },
      ),
    );

    if (config.enableLogging && kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  final Dio dio;
  final SharedPreferences _prefs;
}
