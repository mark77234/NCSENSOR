import 'package:NCSensor/widgets/common/ncs_app_bar.dart';
import 'package:NCSensor/widgets/common/ncs_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../history/history_screen.dart';
import '../measure/select_screen.dart';
import '../profile/profile_screen.dart';
import '../statistics/statistics_screen.dart';

class MainScreen extends StatefulWidget {
  // 상태관리 위젯
  const MainScreen({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 상태관리 클래스
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<PageData> navPages = [
    // 페이지 데이터 리스트
    PageData(SelectScreen(), '항목', Icons.home),
    PageData(HistoryScreen(), '기록', Icons.history),
    PageData(StatisticsScreen(), '통계', Icons.analytics_outlined),
    PageData(ProfileScreen(), '프로필', Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NCSAppBar(title: navPages[_selectedIndex].label),
      body: SafeArea(child: navPages[_selectedIndex].widget),
      bottomNavigationBar: NCSBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          navPages: navPages),
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
