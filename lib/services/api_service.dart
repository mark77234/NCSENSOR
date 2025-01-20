import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:taesung1/models/history_model.dart';
import 'package:taesung1/models/user_model.dart';

import '../constants/infra.dart';
import '../models/measure_model.dart';
import '../models/statistic_data_model.dart';
import 'package:taesung1/models/result_model.dart';
import 'package:taesung1/models/aritcle_model.dart';
import 'api_client.dart';

class ApiService {
  static final Dio _apiClient = createClient(baseUrl);

  static Future<void> login(
      {required String username, required String password}) async {
    await _apiClient.post('/login', data: {
      'username': username,
      'password': password,
    });
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

  static Future<BodyResultData> getBodyData() async {
    final response = await _apiClient.get('/measure');
    return BodyResultData.fromJson(response.data);
  }

  static Future<ArticleData> getArticleData() async {
    final response = await _apiClient.get('/measure/articles');
    return ArticleData.fromJson(response.data);
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

  static Future<UserProfile> getUserProfile() async {
    final response = await _apiClient.get('/my');
    return UserProfile.fromJson(response.data);
  }
}
