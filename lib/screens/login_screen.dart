import 'package:flutter/material.dart';
import 'package:taesung1/constants/styles.dart';
import 'package:taesung1/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildTextField({required String label, bool isPassword = false}) {
    return Center(
      child: SizedBox(
        width: 320,
        height: 50,
        child: TextField(
          obscureText: isPassword ? _obscureText : false,
          decoration: InputDecoration(
            labelText: '    $label',
            labelStyle: TextStyle(color: Color(0xFFB0B0B0)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: ColorStyles.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: ColorStyles.grey, width: 2),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Color(0xFFB0B0B0),
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  // 로그인 버튼을 생성하는 메서드
  Widget _buildLoginButton() {
    return SizedBox(
      width: 320,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text('로그인'),
      ),
    );
  }

  Widget _buildLinkText({required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'N.C.SENSOR',
              style: TextStyle(
                fontSize: 50,
                color: Color(0xFF3B82F6),
                fontFamily: 'DoHyeon',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
            _buildTextField(label: '이메일 계정'),
            const SizedBox(height: 10),
            _buildTextField(label: '비밀번호', isPassword: true),
            const SizedBox(height: 20),
            _buildLoginButton(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLinkText(text: "아이디 찾기", onTap: () {}),
                const SizedBox(width: 60),
                _buildLinkText(text: "비밀번호 찾기", onTap: () {}),
                const SizedBox(width: 60),
                _buildLinkText(
                    text: '회원가입',
                    onTap: () {
                      print('회원가입');
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
