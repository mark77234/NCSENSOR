import 'package:NCSensor/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../screens/common/main_screen.dart';

class NCSBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<PageData> navPages;

  const NCSBottomNavBar({
    super.key,
    required this.navPages,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: navPages
          .map(
            (page) => BottomNavigationBarItem(
              icon: Icon(page.icon, color: Colors.grey),
              activeIcon: Icon(page.icon, color: ColorStyles.primary),
              label: page.label,
            ),
          )
          .toList(),
      selectedItemColor: ColorStyles.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }
}
