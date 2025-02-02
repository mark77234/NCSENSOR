import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:NCSensor/screens/splash/main_screen.dart';
import '../../constants/styles.dart';
import '../../providers/auth_provider.dart';
import 'package:NCSensor/screens/auth/register_screen.dart';

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
  String? _errorMessage; // ? ->  null 값을 가질 수 있다.


  @override
  void dispose() { // TextEditingController 에서 사용하는 메모리 반환, 리소스 회수 -> 앱 성능 관리
    _idEntered.dispose();
    _passwordEntered.dispose();
    super.dispose();
  }

  void _togglePasswordHide() { // 비밀번호 숨김 여부
    setState(() {
      _hideText = !_hideText;
    });
  }

  Widget _buildInputField({  // 입력 필드
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
          obscureText: isPassword ? _hideText : false, // isPassword가 true면 hideText, false면 false 반환 / '*'표시
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: ColorStyles.darkgrey,),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: ColorStyles.darkgrey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: ColorStyles.darkgrey, width: 2),
            ),
            suffixIcon: isPassword  // 비밀번호칸인지 확인 / 입력 위젯에 추가할 수 있는 아이콘
                ? IconButton(
              icon: Icon(
                _hideText ? Icons.visibility_off : Icons.visibility,
                color: ColorStyles.darkgrey,
              ),
              onPressed: _togglePasswordHide,
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
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
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

  Widget _buildRegisterButton() {
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

  Future<void> _handleLogin() async {
    try {
      await context
          .read<AuthProvider>() // 메소드
          .login(_idEntered.text.trim(), _passwordEntered.text.trim()); // trim -> 앞뒤 공백 제거

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
          title: const Text('로그인 실패'),
          content: Text(
            _errorMessage ?? '알 수 없는 오류가 발생했습니다.', // null인 경우 해결
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
            const Text(
              'N.C.SENSOR',
              style: TextStyle(
                fontSize: 50,
                color: Color(0xFF3B82F6),
                fontFamily: 'DoHyeon',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 40),
            _buildInputField(label: '아이디', controller: _idEntered),
            const SizedBox(height: 10),
            _buildInputField(
              label: '비밀번호',
              isPassword: true,
              controller: _passwordEntered,
            ),
            const SizedBox(height: 20),
            _buildLoginButton(),
            const SizedBox(height: 20),
            _buildRegisterButton(),
          ],
        ),
      ),
    );
  }
}
