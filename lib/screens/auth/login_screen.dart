import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/screens/common/main_screen.dart';
import 'package:NCSensor/widgets/common/error_dialog.dart';
import 'package:NCSensor/widgets/screens/login/input_field.dart';
import 'package:NCSensor/widgets/screens/login/register_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../exceptions/error_message.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/screens/login/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // TextEditingController 텍스트를 관리하는 객체(입력,읽기,수정)
  final TextEditingController _idEntered = TextEditingController();
  final TextEditingController _passwordEntered = TextEditingController();
  bool _hideText = true; // 비밀번호 숨김여부
  bool devMode = true;

  @override
  void initState() {
    super.initState();
    if (devMode) {
      // 테스트용
      _idEntered.text = 'tsei';
      _passwordEntered.text = 'tsei1234';
    }
  }

  @override
  void dispose() {
    // TextEditingController 에서 사용하는 메모리 반환, 리소스 회수 -> 앱 성능 관리
    _idEntered.dispose();
    _passwordEntered.dispose();
    super.dispose();
  }

  void _togglePasswordHide() {
    // 비밀번호 숨김 여부
    setState(() {
      _hideText = !_hideText;
    });
  }

  Future<void> _handleLogin() async {
    try {
      await context.read<AuthProvider>().login(_idEntered.text.trim(),
          _passwordEntered.text.trim()); // trim -> 앞뒤 공백 제거

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } catch (e) {
      final errorMessage = getErrorMessage(e);
      print(e);
      _showErrorDialog(errorMessage);
    }
  }

  void _showErrorDialog(String error) {
    showDialog(
        context: context,
        builder: (context) => ErrorDialog(
              errorMessage: error,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTitle(),
            const SizedBox(height: 20),
            Container(
              decoration: ContainerStyles.block,
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(4),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  InputField(
                    label: '아이디',
                    controller: _idEntered,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    label: '비밀번호',
                    isPassword: true,
                    controller: _passwordEntered,
                    hideText: _hideText,
                    togglePasswordHide: _togglePasswordHide,
                  ),
                  const SizedBox(height: 20),
                  LoginButton(
                    onPressed: _handleLogin,
                  ),
                  const SizedBox(height: 20),
                  RegisterButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    return const Text('NCSENSOR', style: TextStyles.apptitle);
  }
}
