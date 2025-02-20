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
    super.message, {
    super.level,
    super.originalError,
    super.stackTrace,
  });
}

class DataParsingException extends CustomException {
  DataParsingException(
    super.message, {
    super.level,
    super.originalError,
    super.stackTrace,
  });
}

class AuthenticationException extends CustomException {
  AuthenticationException(
    super.message, {
    super.level = ErrorLevel.critical,
    super.originalError,
    super.stackTrace,
  });
}

class ValidationException extends CustomException {
  ValidationException(
    super.message, {
    super.level = ErrorLevel.warning,
    super.originalError,
    super.stackTrace,
  });
}

class BusinessLogicException extends CustomException {
  BusinessLogicException(
    super.message, {
    super.level,
    super.originalError,
    super.stackTrace,
  });
}
