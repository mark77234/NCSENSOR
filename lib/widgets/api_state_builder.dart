import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../utils/api_hook.dart';
import 'empty_display_box.dart';
import 'error_box.dart';

class ApiStateBuilder extends StatelessWidget {
  const ApiStateBuilder(
      {super.key,
      required this.apiState,
      required this.builder,
      this.loadingText,
      this.title,
      this.icon});

  final String? title;
  final IconData? icon;
  final ApiState apiState;
  final Widget Function(BuildContext context, dynamic data) builder;
  final String? loadingText;

  @override
  Widget build(BuildContext context) {
    if (apiState.isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            CircularProgressIndicator(
              strokeWidth: 8, // 두께 조절
              valueColor: AlwaysStoppedAnimation<Color>(ColorStyles.primary),
              backgroundColor: ColorStyles.lightgrey,
            ),
            const SizedBox(height: 20),
            if (loadingText != null) ...[
              Text(
                loadingText!,
                style: const TextStyle(
                  fontFamily: "DoHyeon",
                  color: ColorStyles.primary,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      );
    }
    if (apiState.error != null) {
      return ErrorBox(
        errorMessage: " ${title ?? "데이터"}을/를 불러오는 중 오류가 발생했습니다.",
      );
    }
    if (apiState.data == null ||
        (apiState.data is List && apiState.data.isEmpty)) {
      return EmptyDisplayBox(
        icon: icon ?? Icons.analytics_outlined,
        text: "${title ?? "데이터"}이/가 없습니다.",
      );
    }
    return builder(context, apiState.data);
  }
}
