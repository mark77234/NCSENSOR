import 'dart:convert';

import 'package:NCSensor/models/data/history_model.dart';
import 'package:NCSensor/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../constants/infra.dart';
import '../models/data/measure_model.dart';
import '../models/data/result_model.dart';
import '../models/data/statistic_model.dart';
import '../models/data/user_model.dart';
import '../models/ui/index.dart';

import '../storage/secure_storage.dart';
import 'api_client.dart';

class ApiService {
  static final Dio _apiClient = createClient(baseUrl);
  late final LoginService _loginService;

  ApiService() {
    _loginService = LoginService(this);
  }

  Dio get client => _apiClient;

  Future<String> login({required String username, required String password}) {
    return _loginService.login(username: username, password: password);
  }

  // JWT 저장
  Future<void> saveToken(String token) async {
    await SecureStorageService.saveToken(token);
  }

  // JWT 읽기
  Future<String?> getToken() async {
    return await SecureStorageService.getToken();
  }

  static Future<void> signup({
    required String username,
    required String password,
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      print(
          '회원가입 요청: username = $username, name = $name, email = $email, phoneNumber = $phoneNumber');

      final response = await _apiClient.post('/signup', data: {
        'username': username,
        'password': password,
        'name': name,
        'email': email,
        'phone_number': phoneNumber,
      });

      if (response.statusCode == 201) {
        // 회원가입 성공
        print('회원가입 성공: 상태 코드 201');
      } else if (response.statusCode == 409) {
        // 중복 아이디 오류
        throw Exception(response.data['msg']); // 중복 아이디 메시지 처리
      } else {
        throw Exception('오류: 상태 코드 ${response.statusCode}');
      }
    } catch (e) {
      print('회원가입 실패: $e');
      throw Exception('회원가입 실패: $e'); // 예외 처리
    }
  }

  static Future<UserProfile> getUserProfile() async {
    final token = await ApiService().getToken();

    if (token == null) {
      throw Exception('JWT 토큰이 없습니다. 다시 로그인 해주세요.');
    }

    final response = await _apiClient.get('/my',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Authorization 헤더에 JWT 포함
          },
        ));

    print(response.data); // 사용자 프로필 출력

    return UserProfile.fromJson(response.data);
  }

  static Future<void> getUser() async {
    await _apiClient.get('/user');
  }

  static Future<List<MeasureLabel>> getMeasureLabel() async {
    final response = await _apiClient.get('/measure/articles');
    return (response.data["articles"] as List)
        .map((e) => MeasureLabel.fromJson(e))
        .toList();
  }

  static Future<List<StatisticData>> getStatisticData(
      {required String labelId, String unit = "MONTH"}) async {
    final response = await _apiClient.get('/report', queryParameters: {
      'article_id': labelId,
      'unit': unit,
    });

    return (response.data["views"] as List)
        .map((e) => StatisticData.fromJson(e))
        .toList();
  }

  static Future<BodyResultData> getBodyData(
      String articleId, List<Map<String, dynamic>> sensors) async {
    String sensorsJson = jsonEncode(sensors);

    try {
      final response = await _apiClient.get('/measure', queryParameters: {
        'article_id': articleId,
        'sensors': sensorsJson,
      });
      return BodyResultData.fromJson(response.data);
    } catch (e) {
      print("error: $e");
      rethrow;
    }
  }

  static Future<List<HistoryData>> getHistoryData(
      {required DateTime start, required DateTime end}) async {
    final response = await _apiClient.get('/history', queryParameters: {
      'start': DateFormat('yyyy-MM-dd').format(start),
      'end': DateFormat('yyyy-MM-dd').format(end),
    });

    return (response.data["history"] as List)
        .map((e) => HistoryData.fromJson(e))
        .toList();
  }

  static Future<UiData> getUiData() async {
    final response = await _apiClient.get('/ui', queryParameters: {
      'version': 1,
    });
    return UiData.fromJson(response.data);
  }
}
