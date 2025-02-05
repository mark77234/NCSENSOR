import 'dart:convert';

import 'package:dio/dio.dart';

import '../../constants/storage_key.dart';
import '../../models/ui/index.dart';
import '../../services/api_service.dart';
import '../base/preferences_storage.dart';

class UiStorage {
  UiStorage._();

  static UiData? _data;

  // null이 될 수 없는 getter
  static UiData get data {
    if (_data == null) {
      throw StateError('UI 데이터가 없습니다.');
    }
    return _data!;
  }

  static Future<void> init() async {
    UiData? localUiData = await UiStorage.load();
    String? error;
    try {
      final uiData = await ApiService.getUiData(version: localUiData?.version);
      if (uiData != null) await UiStorage.save(uiData);
      if (_data == null) error = "초기화에 실패했습니다.";
    } on DioException catch (e) {
      error = "네트워크 문제 : ${e.message}";
      if (e.type == DioExceptionType.connectionError) {
        error = localUiData == null ? '인터넷 연결이 필요합니다.' : null;
      }
    }
    if (error != null) {
      throw Exception(error);
    }
  }

  // 초기화 (앱 시작시 호출)
  static Future<UiData?> load() async {
    try {
      final jsonString = PreferencesStorage.read(StorageKey.ui);
      if (jsonString != null) {
        _data = UiData.fromJson(jsonDecode(jsonString));
      }
      return _data;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // UI 데이터 저장
  static Future<void> save(UiData data) async {
    final jsonString = jsonEncode({
      'version': data.version,
      'articles': data.articles,
      'stats': data.stats,
    });
    await PreferencesStorage.save(StorageKey.ui, jsonString);
    _data = data;
  }
}
