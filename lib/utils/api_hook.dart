import 'dart:async';

import 'package:collection/collection.dart';

import 'base_hook.dart';

class ApiState<T> {
  final bool isLoading;
  final String? error;
  final T? data;
  final Function reFetch;

  ApiState({
    required this.isLoading,
    required this.error,
    required this.data,
    required this.reFetch,
  });

  ApiState<T> copyWith({
    bool? isLoading,
    String? error,
    T? data,
    Function? reFetch,
  }) {
    return ApiState<T>(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
      reFetch: reFetch ?? this.reFetch,
    );
  }

  @override
  String toString() {
    return 'ApiState(isLoading: $isLoading, error: $error, data: $data)';
  }
}

class ApiHook<T> extends BaseHook<ApiState<T>> {
  final Function? _onError;
  final Function _apiCall;
  Map<String, dynamic>? _params;
  final Duration? _debounceTime;
  Timer? _debounceTimer;
  final DeepCollectionEquality _deepCollectionEquality =
      DeepCollectionEquality();

  ApiHook({
    required Function apiCall,
    Function? onError,
    Map<String, dynamic>? params,
    Duration? debounceTime,
  })  : _params = params,
        _apiCall = apiCall,
        _onError = onError,
        _debounceTime = debounceTime ?? Duration(milliseconds: 500),
        super(ApiState<T>(
          isLoading: false,
          error: null,
          data: null,
          reFetch: () {}, // 초기화 시점에 _fetchData를 설정
        )) {
    state = state.copyWith(reFetch: _debounceFetch);
    _debounceFetch();
  }

  void _debounce(Function() action) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel(); //이미 있다면 취소
    }
    _debounceTimer = Timer(_debounceTime!, action);
  }

  void _fetchData() async {
    print('API 호출');
    state = state.copyWith(isLoading: true, error: null);
    try {
      late final result;
      if (_params == null) {
        result = await _apiCall();
      } else {
        result = await _apiCall(_params);
      }
      print('API 호출 성공 : $result');
      state = state.copyWith(data: result, isLoading: false);
    } catch (err, stackTrace) {
      state = state.copyWith(error: err.toString(), isLoading: false);
      print('에러 발생 : $err');
      print(stackTrace);
      if (_onError != null) {
        _onError(err);
      }
    }
  }

  void _debounceFetch() {
    _debounce(_fetchData);
  }

  // didUpdateWidget 에서 호출하는 것을 권장한다.
  // build 내부에서 호출해도 되긴 한다. 근데 불필요한 호출이 될 수 있다.
  void updateParams(Map<String, dynamic> newParams) {
    if (_deepCollectionEquality.equals(_params, newParams)) return;
    _debounce(
      () {
        _params = newParams;
        _fetchData();
      },
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
