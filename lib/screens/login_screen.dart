import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taesung1/screens/main_screen.dart';
import 'package:taesung1/services/api_service.dart'; // 메인 화면 경로
import '../providers/auth_provider.dart'; // AuthProvider 경로

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String _errorMessage = ''; // 오류 메시지를 저장할 변수

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildTextField(
      {required String label,
        bool isPassword = false,
        required TextEditingController controller}) {
    return Center(
      child: SizedBox(
        width: 320,
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: isPassword ? _obscureText : false,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Color(0xFFB0B0B0)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey, width: 2),
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

  Widget _buildLoginButton() {
    return SizedBox(
      width: 320,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          try {
            // 로그인 요청
            final token = await ApiService.login(
              username: _idController.text,
              password: _passwordController.text,
            );

            // JWT 저장
            await ApiService().saveToken(token);

            // 로그인 성공 시 상태 업데이트
            context.read<AuthProvider>().login();

            // 로그인 성공 시 메인 화면으로 이동
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          } catch (e) {
            // 로그인 실패 시 처리
            setState(() {
              _errorMessage = e.toString(); // 서버에서 받은 실패 메시지
            });
          }
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
            _buildTextField(label: '아이디', controller: _idController),
            const SizedBox(height: 10),
            _buildTextField(
                label: '비밀번호',
                isPassword: true,
                controller: _passwordController),
            const SizedBox(height: 20),
            _buildLoginButton(),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty) // 오류 메시지 표시
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
          ],
        ),
      ),
    );
  }
}