import 'base_hook.dart';

class ApiHookModel {
  final bool isLoading;
  final bool error;
  final dynamic data;
  final Function reFetch;
  final bool isCashed;

  ApiHookModel({
    required this.isLoading,
    required this.error,
    required this.data,
    required this.reFetch,
    required this.isCashed,
  });

  ApiHookModel copyWith({
    bool? isLoading,
    bool? error,
    dynamic data,
    Function? reFetch,
    bool? isCashed,
  }) {
    return ApiHookModel(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
      reFetch: reFetch ?? this.reFetch,
      isCashed: isCashed ?? this.isCashed,
    );
  }
}

class ApiHook extends BaseHook<ApiHookModel> {
  ApiHook()
      : super(ApiHookModel(
          isLoading: false,
          error: false,
          data: null,
          reFetch: () {},
          isCashed: false,
        ));

  void startLoading() {
    state = state.copyWith(isLoading: true);
  }

  void setError(bool error) {
    state = state.copyWith(error: error);
  }

  void setData(dynamic data) {
    state = state.copyWith(isLoading: false, error: false, data: data);
  }

  void setReFetch(Function reFetch) {
    state = state.copyWith(reFetch: reFetch);
  }

  void setIsCashed(bool isCashed) {
    state = state.copyWith(isCashed: isCashed);
  }
}
