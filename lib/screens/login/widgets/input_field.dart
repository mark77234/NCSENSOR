import 'package:flutter/material.dart';

import '../../../constants/styles.dart';

class InputField extends StatelessWidget {
  final String label;
  final bool isPassword;
  final bool hideText;
  final TextEditingController controller;
  final VoidCallback? togglePasswordHide;

  const InputField(
      {super.key,
      required this.label,
      this.isPassword = false,
      this.hideText = true,
      required this.controller,
      this.togglePasswordHide});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: SizeStyles.getMediaWidth(context, 0.8),
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: isPassword ? hideText : false,
          // isPassword가 true면 hideText, false면 false 반환 / '*'표시
          decoration: InputDecoration(
            labelText: label,
            labelStyle: MeasureTextStyles.sub.copyWith(
              fontSize: SizeStyles.getMediaWidth(context, 0.05),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  const BorderSide(color: ColorStyles.darkgrey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide:
                  const BorderSide(color: ColorStyles.darkgrey, width: 2),
            ),
            suffixIcon: isPassword // 비밀번호칸인지 확인 / 입력 위젯에 추가할 수 있는 아이콘
                ? IconButton(
                    icon: Icon(
                      hideText ? Icons.visibility_off : Icons.visibility,
                      color: ColorStyles.darkgrey,
                    ),
                    onPressed: togglePasswordHide,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
