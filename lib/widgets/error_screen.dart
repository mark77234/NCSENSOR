import 'package:flutter/material.dart';

import 'error_box.dart';

class ErrorScreen extends StatelessWidget {
  final String? errorMessage;

  const ErrorScreen({
    super.key,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('에러'),
      ),
      body: Center(
        child: ErrorBox(errorMessage: errorMessage),
      ),
    );
  }
}
