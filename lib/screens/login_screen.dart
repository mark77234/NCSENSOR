import 'package:flutter/material.dart';
import 'package:taesung1/screens/main_screen.dart';
import 'package:taesung1/screens/measure_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true; // 비밀번호 숨김 여부
  bool _isChecked = false; // 자동 로그인 체크 여부

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText; // 비밀번호 표시/숨기기 토글
    });
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
                fontSize: 40,
                color: Color(0xFF3B82F6),
                fontFamily: 'DoHyeon',
              ),
            ),
            const SizedBox(height: 60),
            // 아이디 텍스트 필드 중앙 정렬
            Center(
              child: Container(
                width: 320,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '    Email address',
                    labelStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFB0B0B0), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFB0B0B0), width: 2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // 비밀번호 텍스트 필드 중앙 정렬
            Center(
              child: Container(
                width: 320, // 비밀번호 필드의 가로 크기 조정
                height: 50,
                child: TextField(
                  obscureText: _obscureText, // _obscureText 상태로 비밀번호 표시/숨기기
                  decoration: InputDecoration(
                    labelText: '    Password',
                    labelStyle: TextStyle(color: Color(0xFFB0B0B0)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFB0B0B0), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Color(0xFFB0B0B0), width: 2),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFFB0B0B0),
                      ),
                      onPressed: _togglePasswordVisibility, // 아이콘 클릭 시 비밀번호 표시/숨기기
                    ),
                  ),
                ),
              ),
            ),
            // 자동 로그인 체크박스
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 120.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                        activeColor: Color(0xFF3B82F6),
                      ),
                      Text('자동 로그인', style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Forgot password? 클릭 시 동작
                    print('Forgot password?');
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF3B82F6), // 텍스트 색상
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 320,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  //mainscreen으로 navigate
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),

                  );
                },
                child: const Text('로그인'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Don't have an account? Sign up
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFB0B0B0), // 연한 회색
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    // Sign up 클릭 시 동작
                    print('Sign up');
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Color(0xFF3B82F6), // 텍스트 색상
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}