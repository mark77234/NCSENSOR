import 'package:flutter/material.dart';
import 'package:taesung1/screens/measure_screen.dart';
import 'package:taesung1/screens/profile_screen.dart';
import 'package:taesung1/screens/statistics_screen.dart';

import '../constants/styles.dart';
import 'history_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;


  final List<PageData> _pages = [
    PageData(MeasureScreen(), '측정', Icons.home),
    PageData(HistoryScreen(), '기록',Icons.history),
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
            icon: Icon(page.icon,color: Colors.grey),
            activeIcon: Icon(page.icon, color: ColorStyles.primary),
            label: page.label,
          ),
      ],
      selectedItemColor:  ColorStyles.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex].label,style: TextStyles.title,),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: 1.0,
              color: Color(0xFFE5E7EB),
            ),
          ),
          Expanded(
            child: _pages[_selectedIndex].widget,
          ),
        ],
      ),
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
