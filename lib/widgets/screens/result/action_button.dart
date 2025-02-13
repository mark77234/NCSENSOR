import 'package:NCSensor/constants/styles.dart';
import 'package:NCSensor/routes/fade_page_route.dart';
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
          Expanded(
            child: OutlinedButton.icon(
              icon: Icon(
                Icons.refresh_rounded,
                size: 20,
                color: ColorStyles.primary,
              ),
              label: Text(
                '다시 측정',
                style: MeasureTextStyles.button.copyWith(
                  color: ColorStyles.primary,
                ),
              ),
              onPressed: () => _navigateToMeasure(),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorStyles.darkgrey,
                side: BorderSide(color: ColorStyles.darkgrey),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
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
              label: Text('확인', style: MeasureTextStyles.button),
              onPressed: () => _navigateToMain(),
              style: FilledButton.styleFrom(
                backgroundColor: ColorStyles.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
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
        FadePageRoute(
            page: MeasureScreen(
          articleId: uuid,
        )));
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
      context,
      FadePageRoute(page: MainScreen()),
    );
  }
}
