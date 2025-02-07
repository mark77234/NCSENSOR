import 'package:flutter/material.dart';

import '../../utils/api_hook.dart';
import 'empty_display_box.dart';

class ApiStateBuilder extends StatelessWidget {
  const ApiStateBuilder(
      {super.key,
      required this.apiState,
      required this.builder,
      this.title,
      this.icon});

  final String? title;
  final IconData? icon;
  final ApiState apiState;
  final Widget Function(BuildContext context, dynamic data) builder;

  @override
  Widget build(BuildContext context) {
    if (apiState.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (apiState.error != null) {
      return EmptyDisplayBox(
        icon: Icons.error,
        text: " ${title ?? "데이터"}을/를 불러오는 중 오류가 발생했습니다.",
      );
    }
    if (apiState.data?.isEmpty ?? true) {
      return EmptyDisplayBox(
        icon: icon ?? Icons.analytics_outlined,
        text: "${title ?? "데이터"}이/가 없습니다.",
      );
    }
    return builder(context, apiState.data);
  }
}
