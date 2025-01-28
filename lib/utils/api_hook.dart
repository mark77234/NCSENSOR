import 'dart:async';

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
}

class ApiHook<T> extends BaseHook<ApiState<T>> {
  final Function? _onError;
  final Function _apiCall;
  Map<String, dynamic>? _params;
  final Duration? _debounceTime;
  Timer? _debounce;

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
    state = state.copyWith(reFetch: _fetchData);
    _debounceFetch();
  }

  void _debounceFetch() {
    if (_debounce?.isActive ?? false) _debounce!.cancel(); //이미 있다면 취소
    _debounce = Timer(_debounceTime!, () {
      _fetchData();
    });
  }

  void _fetchData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      late final result;
      if (_params == null) {
        result = await _apiCall();
      } else {
        result = await _apiCall(_params);
      }
      state = state.copyWith(data: result, isLoading: false);
    } catch (err) {
      state = state.copyWith(error: err.toString(), isLoading: false);
      print('에러 발생 : $err');
      if (_onError != null) {
        _onError(err);
      }
    }
  }

  void updateParams(Map<String, dynamic> newParams) {
    // 이전 param과 확인하고 update
    if (_params != newParams) {
      _params = newParams;
      _debounceFetch();
    }
  }
}
