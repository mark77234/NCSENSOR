import 'package:dio/dio.dart';

import '../constants/infra.dart';
import 'api_client.dart';

class ApiService {
  static final Dio _apiClient = createClient(baseUrl);

  static Future<void> login() async {
    await _apiClient.post('/login');
  }

  static Future<void> getUser() async {
    await _apiClient.get('/user');
  }
}
