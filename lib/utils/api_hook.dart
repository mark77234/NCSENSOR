

// class ApiHook extends BaseHook<ApiHookModel> {
//   //isLoading , error, data , refetch , isCashed
// }

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
}
