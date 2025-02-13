import 'package:flutter/material.dart';

import '../../../screens/auth/register_screen.dart';

class RegisterButton extends StatelessWidget{
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
        style: TextStyle(color: Color(0xFF3B82F6),fontFamily: 'Pretendard',),
      ),
    );
  }

}