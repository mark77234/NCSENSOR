import 'package:flutter/material.dart';
import 'package:taesung1/screens/measure_screen.dart';
import 'package:taesung1/screens/profile_screen.dart';
import 'package:taesung1/screens/statistics_screen.dart';

import '../constants/styles.dart';
import 'history_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  int _selectedIndex = 0;

  final List<PageData> _pages = [
    PageData(MeasureScreen(), '측정', Icons.home),
    PageData(HistoryScreen(), '기록', Icons.history),
    PageData(StatisticsScreen(), '통계', Icons.analytics_outlined),
    PageData(ProfileScreen(), '프로필', Icons.person),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        for (final page in _pages)
          BottomNavigationBarItem(
            icon: Icon(page.icon, color: Colors.grey),
            activeIcon: Icon(page.icon, color: ColorStyles.primary),
            label: page.label,
          ),
      ],
      selectedItemColor: ColorStyles.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex].widget,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

class PageData {
  final Widget widget;
  final String label;
  final IconData icon;

  PageData(
    this.widget,
    this.label,
    this.icon,
  );
}
