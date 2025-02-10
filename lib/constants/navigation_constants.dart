import 'package:NCSensor/screens/history/history_screen.dart';
import 'package:NCSensor/screens/measure/select_screen.dart';
import 'package:NCSensor/screens/profile/profile_screen.dart';
import 'package:NCSensor/screens/statistics/statistics_screen.dart';
import 'package:flutter/material.dart';

class PageData{
  final Widget widget;
  final String label;
  final IconData icon;

  PageData(
      this.widget,
      this.label,
      this.icon,
      );
}

List<PageData> navPages = [
  // 페이지 데이터 리스트
  PageData(SelectScreen(), '측정', Icons.home),
  PageData(HistoryScreen(), '기록', Icons.history),
  PageData(StatisticsScreen(), '통계', Icons.analytics_outlined),
  PageData(ProfileScreen(), '프로필', Icons.person),
];