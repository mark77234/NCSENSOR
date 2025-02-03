import 'package:NCSensor/utils/api_hook.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiHook 테스트', () {
    test('초기 상태 확인', () {
      final hook = ApiHook(
        apiCall: () async => 'test',
      );

      expect(hook.state.isLoading, false);
      expect(hook.state.error, null);
      expect(hook.state.data, null);
      expect(hook.state.reFetch is Function, true);
    });

    test('API 호출 성공 시나리오', () async {
      final hook = ApiHook(
        apiCall: () async => 'success',
        debounceTime: Duration(milliseconds: 0),
      );

      await Future.delayed(Duration(milliseconds: 10));

      expect(hook.state.isLoading, false);
      expect(hook.state.data, 'success');
      expect(hook.state.error, null);
    });

    test('API 호출 실패 시나리오', () async {
      bool onErrorCalled = false;

      final hook = ApiHook(
        apiCall: () async => throw Exception('API 에러'),
        onError: (err) => onErrorCalled = true,
        debounceTime: Duration(milliseconds: 0),
      );

      await Future.delayed(Duration(milliseconds: 10));

      expect(hook.state.isLoading, false);
      expect(hook.state.data, null);
      expect(hook.state.error, 'Exception: API 에러');
      expect(onErrorCalled, true);
    });

    test('디바운스 기능 테스트', () async {
      int callCount = 0;

      final hook = ApiHook(
        apiCall: () async {
          callCount++;
          return 'test';
        },
        debounceTime: Duration(milliseconds: 100),
      );

      hook.state.reFetch();
      hook.state.reFetch();
      hook.state.reFetch();

      await Future.delayed(Duration(milliseconds: 150));

      expect(callCount, 1);
    });

    test('파라미터 업데이트 테스트', () async {
      Map<String, dynamic>? lastParams;

      final hook = ApiHook(
        apiCall: (params) async {
          lastParams = params;
          return 'test';
        },
        params: {'initial': 'value'},
        debounceTime: Duration(milliseconds: 0),
      );

      await Future.delayed(Duration(milliseconds: 10));
      expect(lastParams, {'initial': 'value'});

      hook.updateParams({'updated': 'value'});
      await Future.delayed(Duration(milliseconds: 10));

      expect(lastParams, {'updated': 'value'});
    });

    test('reFetch 기능 테스트', () async {
      int callCount = 0;

      final hook = ApiHook(
        apiCall: () async {
          callCount++;
          return 'test';
        },
        debounceTime: Duration(milliseconds: 0),
      );

      await Future.delayed(Duration(milliseconds: 10));
      expect(callCount, 1);

      hook.state.reFetch();
      await Future.delayed(Duration(milliseconds: 10));

      expect(callCount, 2);
    });
  });
}
