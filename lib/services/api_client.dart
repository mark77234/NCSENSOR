import 'package:dio/dio.dart';
import 'package:taesung1/services/interceptor.dart';

Dio createClient(baseUrl) {
  return Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ))
    ..interceptors.add(CustomInterceptors());
}
