import 'package:NCSensor/constants/navigation_constants.dart';
import 'package:NCSensor/widgets/common/ncsAppBar.dart';
import 'package:NCSensor/widgets/common/ncsBottomNavigationBar.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NCSAppBar(title: navPages[_selectedIndex].label),
      body: SafeArea(child: navPages[_selectedIndex].widget),
      bottomNavigationBar:
          NCSBottomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}
