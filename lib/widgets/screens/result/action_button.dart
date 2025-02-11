import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/screens/common/main_screen.dart';
import 'package:NCSensor/screens/measure/measure_screen.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final BuildContext context;
  final String uuid;

  const ActionButton({
    super.key,
    required this.context,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          // 다시 측정 버튼
          Expanded(
            child: OutlinedButton.icon(
              icon: Icon(Icons.refresh_rounded, size: 20),
              label: const Text('다시 측정'),
              onPressed: () => _navigateToMeasure(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[800],
                side: BorderSide(color: Colors.grey[300]!),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'DoHyeon',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                elevation: 0,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // 확인 버튼
          Expanded(
            child: FilledButton.icon(
              icon: Icon(Icons.check_rounded, size: 20),
              label: const Text('확인'),
              onPressed: () => _navigateToMain(),
              style: FilledButton.styleFrom(
                backgroundColor: ColorStyles.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontFamily: 'DoHyeon',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToMeasure() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => MeasureScreen(uuid),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const MainScreen(),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }
}