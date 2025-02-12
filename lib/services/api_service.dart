import 'dart:convert';

import 'package:NCSensor/models/data/history_model.dart';
import 'package:NCSensor/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../constants/infra.dart';
import '../models/data/result_model.dart';
import '../models/data/statistic_model.dart';
import '../models/meta/ncs_meta.dart';
import 'api_client.dart';

/// api 정의하는 클래스
class ApiService {
  static final Dio _apiClient = createClient(baseUrl);
  static final Options _authedOption = Options(
    headers: {
      'Authorization': true,
    },
  );

  static final user = UserService(_apiClient, _authedOption);

  ApiService._();

  static Future<BodyResultData> getResultData(
      String articleId, List<Map<String, dynamic>> sensors) async {
    String sensorsJson = jsonEncode(sensors);
    final response = await _apiClient.get('/measure',
        queryParameters: {
          'article_id': articleId,
          'sensors': sensorsJson,
        },
        options: _authedOption);
    return BodyResultData.fromJson(response.data);
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
    } catch (err, stace) {
      print('에러 발생 : $err');
      print(stace);
      return null;
    }
  }
}
