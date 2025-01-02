import 'package:flutter/material.dart';
import 'login_screen.dart'; // Loginscreen 파일 import

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        _createRoute(),
      );
    });
  }

  // 화면 전환 애니메이션을 정의하는 함수
  PageRouteBuilder _createRoute() {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {

        // 페이드 효과 추가 (서서히 나타나는 효과)
        var opacityTween = Tween(begin: 0.0, end: 1.0);
        var opacityAnimation = animation.drive(opacityTween);

        // FadeTransition을 사용하여 애니메이션 적용
        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Row의 자식들을 가운데 정렬
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 160.0), // 오른쪽으로 160px 떨어지도록 설정
                        child: Icon(
                          Icons.sensors,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'N.C.SENSOR',
                    style: TextStyle(
                      fontSize: 50,
                      color: Color(0xFF000080),
                      fontFamily: 'DoHyeon',
                    ),
                  ),
                  Icon(
                    Icons.air,
                    size: 80,
                    color: Colors.blue,
                  ),
                  Text(
                    'Breath Analysis System',
                    style: TextStyle(
                      fontSize:15,
                      color: Color(0xFF2563EB),
                    )
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Advanced breath analysis for\nalcohol and oral health detection',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF808080),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // "N.C.SENSOR" 텍스트를 오른쪽 밑에 배치
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'N.C.SENSOR',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}