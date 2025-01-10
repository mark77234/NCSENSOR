import 'package:dio/dio.dart';
import 'package:taesung1/constants/infra.dart';
import 'package:taesung1/services/interceptor.dart';

Dio createClient() {
  return Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
    headers: {
      'Content-Type': 'application/json',
    },
  ))..interceptors.add(CustomInterceptors());
}