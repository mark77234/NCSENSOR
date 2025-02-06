import 'dart:developer';

import 'package:dio/dio.dart';

import '../storage/data/auth_storage.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Do something before request is sent
    log('[REQ] [${options.method}] ${options.uri} ${options.data} ${options.headers}');
    if (options.headers['Authorization'] == true) {
      options.headers.remove('Authorization');
      final token = AuthStorage.accessToken;
      print('토큰: $token');
      if (token == null) {
        throw Exception('토큰이 없습니다.');
      }
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Do something with response data
    log('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri} ${response.data?.toString()}  ');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri} ${err.response?.statusCode} ${err.requestOptions.data} ${err.response?.data}');
    log('에러 상태코드 ${err.response?.statusCode}');
    log('에러 데이터: ${err.response?.data}');
    handler.next(err);
  }
}
