import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String? errorMessage;

  const ErrorScreen({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 48,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage ?? "데이터를 찾을 수 없습니다.",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
