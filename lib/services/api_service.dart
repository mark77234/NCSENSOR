import 'package:dio/dio.dart';

import '../constants/infra.dart';
import '../models/measure_model.dart';
import '../models/statistic_data_model.dart';
import 'package:taesung1/models/bodyresult_model.dart';

import 'api_client.dart';

class ApiService {
  static final Dio _apiClient = createClient(baseUrl);

  static Future<void> login() async {
    await _apiClient.post('/login');
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

//
// static Future<void> getHistoryData(
//     {required DateTime start, required DateTime end}) async {
//   await _apiClient.get('/history', queryParameters: {
//     'start': DateFormat('yyyy-MM-dd').format(start),
//     'end': DateFormat('yyyy-MM-dd').format(end),
//   });
// }

}
