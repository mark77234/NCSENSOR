import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taesung1/screens/main_screen.dart';
import 'package:taesung1/services/api_service.dart';
import '../../providers/auth_provider.dart';
import 'package:taesung1/screens/login/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String _errorMessage = '';

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildTextField({
    required String label,
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return Center(
      child: SizedBox(
        width: 320,
        height: 50,
        child: TextField(
          controller: controller,
          obscureText: isPassword ? _obscureText : false,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: const Color(0xFFB0B0B0)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.grey, width: 2),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFFB0B0B0),
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  // 로그인 버튼
  Widget _buildLoginButton() {
    return SizedBox(
      width: 320,
      height: 50,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          '로그인',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _registerField() {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
      child: Text(
        '회원가입',
        style: TextStyle(color: const Color(0xFF3B82F6)),
      ),
    );
  }

  // 로그인 처리 함수
  Future<void> _handleLogin() async {
    try {
      final token = await ApiService.login(
        username: _idController.text,
        password: _passwordController.text,
      );

      await ApiService().saveToken(token);

      context.read<AuthProvider>().login();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String error) {
    setState(() {
      _errorMessage = error;
    });

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('로그인 오류'),
          content: Text(
            "아이디 혹은 비밀번호가 일치하지 않습니다",
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
      },
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
                color: const Color(0xFF3B82F6),
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
            _registerField(),
          ],
        ),
      ),
    );
  }
}
