import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_appp/app/core/exceptions/expire_tokne_exception.dart';
import 'package:dw9_delivery_appp/app/core/global/global_context.dart';
import 'package:dw9_delivery_appp/app/core/rest_client/custom_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  final CustomDio _dio;

  AuthInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final accessToken = sp.getString('accessToken');
    options.headers['Authorization'] = 'Bearer $accessToken';

    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        if (err.requestOptions.path != '/auth/refresh') {
          await _refreshToken(err);
          await _retryRequest(err, handler);
        } else {
          GlobalContext.instance.loginExpire();
        }
      } catch (e) {
        GlobalContext.instance.loginExpire();
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> _refreshToken(DioError err) async {
    try {
      final sp = await SharedPreferences.getInstance();
      final refreshToken = sp.getString('refreshToken');

      if (refreshToken == null) {
        return;
      }
      final resultRefresh = await _dio.auth().put('/auth/refresh', data: {
        'refresh_token': refreshToken,
      });

      sp.setString('accessToken', resultRefresh.data['access_token']);
      sp.setString('refreshToken', resultRefresh.data['refresh_token']);
    } on DioError catch (e, s) {
      log('Erro ao realizar refreshToken', error: e, stackTrace: s);
      throw ExpireTokneException();
    }
  }

  Future<void> _retryRequest(
      DioError err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    final result = await _dio.request(
      requestOptions.path,
      options: Options(
        headers: requestOptions.headers,
        method: requestOptions.method,
      ),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ),
    );
  }
}
