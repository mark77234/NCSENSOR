import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../screens/common/main_screen.dart';
import '../../../screens/measure/measure_screen.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureScreen(uuid),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: ColorStyles.primary),
            fixedSize: const Size(150, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            '다시측정',
            style: TextStyle(
              color: ColorStyles.primary,
              fontSize: 16,
              fontFamily: "BaeMin",
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorStyles.primary,
            fixedSize: const Size(150, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: const Text(
            '확인',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "BaeMin",
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
