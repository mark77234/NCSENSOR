import 'package:NCSensor/routes/fade_page_route.dart';
import 'package:NCSensor/screens/common/main_screen.dart';
import 'package:flutter/material.dart';

import '../../constants/styles.dart';

class NCSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NCSAppBar({
    super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        TextButton(
            onPressed: () => Navigator.pushReplacement(
                  context,
                  FadePageRoute(page: MainScreen()),
                ),
            child: Text(
              "NCSENSOR",
              style: TextStyles.apptitle.copyWith(fontSize: 30),
            )),
        Text(
          title,
          style: const TextStyle(
              color: ColorStyles.darkgrey,
              fontSize: 25,
              fontFamily: 'DoHyeon',
              fontWeight: FontWeight.w300),
        ),
      ]),
    );
  }
}
