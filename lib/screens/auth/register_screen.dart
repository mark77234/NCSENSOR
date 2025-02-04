import 'package:NCSensor/services/api_service.dart'; // ApiService 경로
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _errorMessage = ''; // 오류 메시지 변수

  void _showErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
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
          obscureText: isPassword,
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
          ),
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: 320,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          try {
            await ApiService.user.signup(
              username: _usernameController.text,
              password: _passwordController.text,
              name: _nameController.text,
              email: _emailController.text,
              phoneNumber: _phoneController.text,
            );
            // 회원가입 성공 후 로그인 화면으로 이동
            Navigator.pop(context); // 회원가입 완료 후 로그인 화면으로 돌아가기
          } catch (e) {
            // 회원가입 실패 시 처리
            _showErrorMessage(e.toString()); // 서버에서 받은 실패 메시지
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
        child: const Text('회원가입'),
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
            _buildTextField(label: '아이디', controller: _usernameController),
            const SizedBox(height: 10),
            _buildTextField(
                label: '비밀번호',
                isPassword: true,
                controller: _passwordController),
            const SizedBox(height: 10),
            _buildTextField(label: '이름', controller: _nameController),
            const SizedBox(height: 10),
            _buildTextField(label: '이메일', controller: _emailController),
            const SizedBox(height: 10),
            _buildTextField(label: '전화번호', controller: _phoneController),
            const SizedBox(height: 20),
            _buildSignupButton(),
            const SizedBox(height: 20),
            if (_errorMessage.isNotEmpty)
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
