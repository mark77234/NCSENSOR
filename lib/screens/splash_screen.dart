import 'package:flutter/material.dart';
import 'package:taesung1/constants/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..forward(); // forward()를 사용하여 애니메이션이 한 번만 실행되도록 변경
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _buildRotatingCircle(150, 0xFF3C82F6, 0.5),
                _buildRotatingCircle(110, 0xFF60A5FA, -1),
                _buildRotatingCircle(75, 0xFFAFD4FD, 1.5),
              ],
            ),
            SizedBox(height: 60),
            Text(
              'N.C.SENSOR',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w500,
                color: ColorStyles.primary,
                fontFamily: 'DoHyeon',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRotatingCircle(
      double size, int colorHex, double rotationFactor) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159 * rotationFactor,
          child: child,
        );
      },
      child: CustomPaint(
        size: Size(size, size),
        painter: CirclePainter(
          borderColor: Color(colorHex),
          gapColor: Colors.white,
          strokeWidth: 6,
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color borderColor;
  final Color gapColor;
  final double strokeWidth;

  CirclePainter({
    required this.borderColor,
    required this.gapColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, paint);

    paint.color = gapColor;

    const gapAngle = 3.14159 / 2;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      gapAngle * 2,
      gapAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
