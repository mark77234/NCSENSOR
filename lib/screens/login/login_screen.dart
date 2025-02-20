import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/screens/login/widgets/input_field.dart';
import 'package:NCSensor/screens/login/widgets/login_button.dart';
import 'package:NCSensor/screens/login/widgets/register_button.dart';
import 'package:NCSensor/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../exceptions/error_message.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';

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
      _idEntered.text = 'lbc';
      _passwordEntered.text = 'lbc1234';
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

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 8, // 두께 조절
            valueColor: AlwaysStoppedAnimation<Color>(ColorStyles.primary),
            backgroundColor: ColorStyles.lightgrey,
          ),
        );
      },
    );

    try {
      await context.read<AuthProvider>().login(_idEntered.text.trim(),
          _passwordEntered.text.trim()); // trim -> 앞뒤 공백 제거
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      final errorMessage = getErrorMessage(e);
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
            _buildTitle(),
            const SizedBox(height: 20),
            Column(
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
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text('NCSENSOR', style: TextStyles.apptitle);
  }
}
