import 'dart:convert';

import 'package:NCSensor/models/data/history_model.dart';
import 'package:NCSensor/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../constants/infra.dart';
import '../models/data/measure_model.dart';
import '../models/data/result_model.dart';
import '../models/data/statistic_model.dart';
import '../models/ui/ncs_meta.dart';
import 'api_client.dart';

class ApiService {
  static final Dio _apiClient = createClient(baseUrl);
  static final Options _authedOption = Options(
    headers: {
      'Authorization': true,
    },
  );

  static final user = UserService(_apiClient, _authedOption);

  ApiService._();

  static Future<List<MeasureLabel>> getMeasureLabel() async {
    final response = await _apiClient.get('/measure/articles');
    return (response.data["articles"] as List)
        .map((e) => MeasureLabel.fromJson(e))
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

  static Future<List<StatisticData>> getStatisticData(
      {required String articleId, String unit = "MONTH"}) async {
    final response = await _apiClient.get('/stats',
        queryParameters: {
          'article_id': articleId,
          'unit': unit,
        },
        options: _authedOption);

    return (response.data["views"] as List)
        .map((e) => StatisticData.fromJson(e))
        .toList();
  }

  static Future<List<HistoryData>> getHistoryData(
      {required DateTime start, required DateTime end}) async {
    final response = await _apiClient.get('/history',
        queryParameters: {
          'start': DateFormat('yyyy-MM-dd').format(start),
          'end': DateFormat('yyyy-MM-dd').format(end),
        },
        options: _authedOption);

    return (response.data["history"] as List)
        .map((e) => HistoryData.fromJson(e))
        .toList();
  }

  static Future<NcsMetaData?> getUiData({int? version}) async {
    final response = await _apiClient.get(
      '/metadata',
      queryParameters: {
        'version': version ?? 0,
      },
    );
    try {
      return response.statusCode == 200
          ? NcsMetaData.fromJson(response.data)
          : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
