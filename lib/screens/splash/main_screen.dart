import 'package:flutter/material.dart';
import 'package:taesung1/screens/measure/select_screen.dart';
import 'package:taesung1/screens/profile/profile_screen.dart';
import 'package:taesung1/screens/statistics/statistics_screen.dart';

import '../../constants/styles.dart';
import '../history/history_screen.dart';

class MainScreen extends StatefulWidget { // 상태관리 위젯
  const MainScreen({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> { // 상태관리 클래스
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  int _selectedIndex = 0;


  final List<PageData> _pages = [ // 페이지 데이터 리스트
    PageData(SelectScreen(), '측정', Icons.home),
    PageData(HistoryScreen(), '기록', Icons.history),
    PageData(StatisticsScreen(), '통계', Icons.analytics_outlined),
    PageData(ProfileScreen(), '프로필', Icons.person),
  ];

  void _onItemTapped(int index) { // 탭 시 인덱스 업데이트
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() { // 네비게이션 바 생성 메소드
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
  Widget build(BuildContext context) { // UI
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex].widget),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

class PageData { // 페이지 데이터 저장 클래스
  final Widget widget;
  final String label;
  final IconData icon;

  PageData(
    this.widget,
    this.label,
    this.icon,
  );
}
