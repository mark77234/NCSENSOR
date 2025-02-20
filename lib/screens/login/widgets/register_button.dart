import 'package:flutter/material.dart';

import '../../register/register_screen.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
      child: const Text(
        '회원가입',
        style: TextStyle(color: Color(0xFF3B82F6)),
      ),
    );
  }
}
