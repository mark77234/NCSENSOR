import 'package:dio/dio.dart';
import 'api_service.dart';

class LoginService {
  final ApiService _apiService;

  LoginService(this._apiService);

  Future<String> login({
    required String username,
    required String password,
  }) async {
    print('\n[로그인 요청] \n아이디: $username\n 비밀번호: $password\n');
    try {
      final response = await _sendLoginRequest(username: username, password: password);
      return _handleLoginResponse(response);
    } catch (e) {
      return await _handleLoginError(e);
    }
  }

  Future<Response> _sendLoginRequest({
    required String username,
    required String password,
  }) async {
    return await _apiService.client.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
      options: Options(
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ),
    );
  }

  String _handleLoginResponse(Response response) {
    if (response.statusCode == 200) {
      final accessToken = response.data['access_token'];
      print('\n< 로그인 성공: access_token = $accessToken >\n');
      return accessToken;
    } else {
      throw Exception('오류 발생: 상태 코드 ${response.statusCode}');
    }
  }

  Future _handleLoginError(Object e) {
    if (e is DioException) {
      print('DioException 발생: ${e.response?.statusCode}');
      if (e.response?.statusCode == 401) {
        final errorMessage = e.response?.data['msg'] ?? '인증 실패';
        print('401 상태 코드 확인: $errorMessage');
        return Future.error(errorMessage);
      } else {
        final errorMsg = e.response?.data['msg'] ?? '서버 오류';
        print('서버 에러 발생: 상태 코드 ${e.response?.statusCode}, 메시지: $errorMsg');
        return Future.error(errorMsg);
      }
    }
    print('예기치 못한 오류 발생: $e');
    throw Exception('로그인 실패: $e');
  }
}