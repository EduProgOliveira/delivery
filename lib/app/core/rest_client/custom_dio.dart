import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dw9_delivery_appp/app/core/config/env/env.dart';
import 'package:dw9_delivery_appp/app/core/rest_client/interceptors/auth_interceptor.dart';

class CustomDio extends DioForNative {
  late AuthInterceptor _authInterceptor;
  CustomDio()
      : super(BaseOptions(
          baseUrl: Env.instance['backend_base_url'] ?? '',
          connectTimeout: 5000,
          receiveTimeout: 60000,
        )) {
    interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: true,
    ));
    _authInterceptor = AuthInterceptor(this);
  }

  CustomDio auth() {
    interceptors.add(_authInterceptor);
    return this;
  }

  CustomDio unauth() {
    interceptors.remove(_authInterceptor);
    return this;
  }
}
