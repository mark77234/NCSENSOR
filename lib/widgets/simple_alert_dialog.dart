import 'package:flutter/material.dart';

Future<void> showSimpleAlert(
  BuildContext context, {
  required String title,
  required String content,
  String? errorText,
  String? buttonText,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(content),
            if (errorText != null) Text("에러 : $errorText"),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text(buttonText ?? '확인'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
