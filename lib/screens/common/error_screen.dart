import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/exceptions/error_message.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.error});

  final dynamic error;

  @override
  Widget build(BuildContext context) {
    final errorMessage = getErrorMessage(error);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: ColorStyles.primary,
            ),
            Text(
              errorMessage,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                fontFamily: "Pretendard",
                color: ColorStyles.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
