import 'package:dio/dio.dart';

import 'api_client.dart';

class ApiService{
  static final Dio _apiClient = createClient();

  static Future<void> login() async {
    await _apiClient.post('/login');
  }

  static Future<void> getUser() async {
    await _apiClient.get('/user');
  }

}

class ApiService2{
  static final Dio apiData = createClient();

}