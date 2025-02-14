import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;

  const ErrorDialog({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('로그인 실패'),
      content: Text(
        errorMessage.isNotEmpty ? errorMessage : '알 수 없는 오류가 발생하였습니다',
        style: const TextStyle(fontSize: 18, color: Colors.grey),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('확인'),
        ),
      ],
    );
  }
}
