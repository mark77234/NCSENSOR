enum ErrorLevel {
  info, // 사소한거 걍 로그만찍힘
  warning, // alert창
  error, // 에
  critical,
}

abstract class CustomException implements Exception {
  final String message;
  final ErrorLevel level;
  final dynamic originalError;
  final StackTrace? stackTrace;

  CustomException(
    this.message, {
    this.level = ErrorLevel.error,
    this.originalError,
    this.stackTrace,
  }) {
    _logError();
  }

  void _logError() {
    final now = DateTime.now();
    print('[$now] ${level.name.toUpperCase()}: $message');
    if (originalError != null) {
      print('에러: $originalError');
    }
    if (stackTrace != null) {
      print('stacktrace: $stackTrace');
    }
  }

  @override
  String toString() => message;
}

class NetworkException extends CustomException {
  NetworkException(
    String message, {
    ErrorLevel level = ErrorLevel.error,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message,
          level: level,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

class DataParsingException extends CustomException {
  DataParsingException(
    String message, {
    ErrorLevel level = ErrorLevel.error,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message,
          level: level,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

class AuthenticationException extends CustomException {
  AuthenticationException(
    String message, {
    ErrorLevel level = ErrorLevel.critical,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message,
          level: level,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

class ValidationException extends CustomException {
  ValidationException(
    String message, {
    ErrorLevel level = ErrorLevel.warning,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message,
          level: level,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}

class BusinessLogicException extends CustomException {
  BusinessLogicException(
    String message, {
    ErrorLevel level = ErrorLevel.error,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
          message,
          level: level,
          originalError: originalError,
          stackTrace: stackTrace,
        );
}
