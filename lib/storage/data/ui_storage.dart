import 'dart:convert';

import 'package:dio/dio.dart';

import '../../constants/storage_key.dart';
import '../../models/ui/index.dart';
import '../../services/api_service.dart';
import '../base/preferences_storage.dart';

class UiStorage {
  UiStorage._();

  static UiData? _data;

  // null이 될 수 없는 getter > UiStorage.data 사용
  static UiData get data {
    if (_data == null) {
      throw StateError('UI 데이터가 없습니다.');
    }
    return _data!;
  }

  static Future<void> init() async {
    await UiStorage._load();
    String? error;
    try {
      final uiData = await ApiService.getUiData(version: _data?.version);
      if (uiData != null) await UiStorage._save(uiData);
      if (_data == null) error = "초기화에 실패했습니다.";
    } on DioException catch (e) {
      error = "네트워크 문제 : ${e.message}";
      if (e.type == DioExceptionType.connectionError) {
        // 인터넷 없어도 기존에 데이터 있을시 에러 제거
        error = _data == null ? '인터넷 연결이 필요합니다.' : null;
      }
    }

    if (error != null) {
      // 에러 전파해서 screen에서 처리
      throw Exception(error);
    }
  }

  // 초기화 (앱 시작시 호출)
  static Future<void> _load() async {
    print('UiStorage : load');
    try {
      final jsonString = PreferencesStorage.read(StorageKey.ui);
      print('UiStorage data : $jsonString');
      if (jsonString != null) {
        _data = UiData.fromJson(jsonDecode(jsonString));
      }
    } catch (e) {
      print(e);
    }
  }

  // UI 데이터 저장
  static Future<void> _save(UiData data) async {
    print('UiStorage : save');
    final jsonString = jsonEncode(data.toJson());
    print('UiStorage data : $jsonString');
    await PreferencesStorage.save(StorageKey.ui, jsonString);
    _data = data;
  }
}
