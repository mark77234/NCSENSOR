import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  // JWT 토큰 저장
  static Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: 'access_token', value: token);
      print('JWT 토큰 저장 성공');
    } catch (e) {
      print('JWT 토큰 저장 실패: $e');
      throw Exception('JWT 토큰 저장 실패: $e');
    }
  }

  // JWT 토큰 읽기
  static Future<String?> getToken() async {
    try {
      final token = await _storage.read(key: 'access_token');
      if (token != null) {
        print('JWT 토큰 읽기 성공');
      } else {
        print('저장된 JWT 토큰이 없습니다.');
      }
      return token;
    } catch (e) {
      print('JWT 토큰 읽기 실패: $e');
      throw Exception('JWT 토큰 읽기 실패: $e');
    }
  }

  // JWT 토큰 삭제
  static Future<void> deleteToken() async {
    try {
      await _storage.delete(key: 'access_token');
      print('JWT 토큰 삭제 성공');
    } catch (e) {
      print('JWT 토큰 삭제 실패: $e');
      throw Exception('JWT 토큰 삭제 실패: $e');
    }
  }

  // 모든 키 삭제
  static Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
      print('모든 데이터 삭제 성공');
    } catch (e) {
      print('모든 데이터 삭제 실패: $e');
      throw Exception('모든 데이터 삭제 실패: $e');
    }
  }
}