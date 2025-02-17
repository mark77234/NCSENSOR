import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

String getErrorMessage(dynamic e) {
  if (e is DioException) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "서버 응답 시간이 초과되었습니다. 네트워크를 확인해주세요.";
      case DioExceptionType.sendTimeout:
        return "서버로 요청을 보내는 데 시간이 너무 오래 걸립니다.";
      case DioExceptionType.receiveTimeout:
        return "서버 응답이 지연되고 있습니다. 다시 시도해주세요.";
      case DioExceptionType.badResponse:
        if (e.response?.statusCode == 400) {
          return "아이디 또는 비밀번호가 올바르지 않습니다.";
        } else if (e.response?.statusCode == 401) {
          return "인증에 실패했습니다. 다시 로그인해주세요.";
        } else if (e.response?.statusCode == 403) {
          return "접근 권한이 없습니다.";
        } else if (e.response?.statusCode == 404) {
          return "요청한 자원을 찾을 수 없습니���.";
        } else if (e.response?.statusCode == 500) {
          return "서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.";
        }
        return "알 수 없는 서버 오류가 발생했습니다. (${e.response?.statusCode})";
      case DioExceptionType.cancel:
        return "요청이 취소되었습니다.";
      case DioExceptionType.unknown:
      default:
        return "알 수 없는 오류가 발생했습니다.";
    }
  } else if (e is SocketException) {
    return "네트워크 연결을 확인해주세요.";
  } else if (e is TimeoutException) {
    return "요청 시간이 초과되었습니다. 다시 시도해주세요.";
  } else {
    return "예기치 않은 오류가 발생했습니다.";
  }
}
