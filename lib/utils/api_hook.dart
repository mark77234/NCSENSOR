import 'base_hook.dart';

class ApiState<T> {
  final bool isLoading;
  final bool error;
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
    bool? error,
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
  final Function? onError;
  final Future<T> Function() apiCall;

  ApiHook({
    required this.apiCall,
    this.onError,
  }) : super(ApiState<T>(
          isLoading: false,
          error: false,
          data: null,
          reFetch: () {}, // 초기화 시점에 _fetchData를 설정
        )) {
    state = state.copyWith(reFetch: _fetchData);
    _fetchData();
  }

  void _fetchData() async {
    if (state.isLoading) return; // 이미 로딩 중이면 반환

    state = state.copyWith(isLoading: true, error: false);
    try {
      final result = await apiCall();
      state = state.copyWith(data: result, isLoading: false);
    } catch (err) {
      state = state.copyWith(error: true, isLoading: false);
      if (onError != null) {
        onError!(err);
      }
    }
  }
}
