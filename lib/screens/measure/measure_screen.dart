import 'package:NCSensor/constants/navigation_constants.dart';
import 'package:NCSensor/screens/history/history_screen.dart';
import 'package:NCSensor/screens/profile/profile_screen.dart';
import 'package:NCSensor/screens/statistics/statistics_screen.dart';
import 'package:NCSensor/widgets/screens/main/ncsAppBar.dart';
import 'package:NCSensor/widgets/screens/main/ncsBottomNavigationBar.dart';
import 'package:flutter/material.dart';
import '../../constants/styles.dart';
import '../../widgets/screens/measure/action_button.dart';
import '../../widgets/screens/measure/progress_circle.dart';
import '../../widgets/screens/measure/sensor_status_card.dart';
import 'result_screen.dart';

class MeasureScreen extends StatefulWidget {
  final String UUID;

  const MeasureScreen(this.UUID, {super.key});

  @override
  State<MeasureScreen> createState() => _MeasureScreenState();
}

class _MeasureScreenState extends State<MeasureScreen> {
  int _selectedIndex = 0;

  final List<PageData> navPages = []; // 이동: initState로 이전

  @override
  void initState() {
    super.initState();
    navPages.addAll([
      PageData(_MeasureContent(UUID: widget.UUID), '항목', Icons.home),
      PageData(const HistoryScreen(), '기록', Icons.history),
      PageData(const StatisticsScreen(), '통계', Icons.analytics_outlined),
      PageData(const ProfileScreen(), '프로필', Icons.person),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NCSAppBar(title: "측정"),
      body: SafeArea(child: navPages[_selectedIndex].widget),
      bottomNavigationBar: NCSBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _MeasureContent extends StatefulWidget {
  final String UUID;

  const _MeasureContent({required this.UUID});

  @override
  State<_MeasureContent> createState() => _MeasureContentState();
}

class _MeasureContentState extends State<_MeasureContent> {
  bool _isLoading = false;
  double _progress = 0.0;
  final String sensorStatus = "인식완료";
  final Color sensorColor = ColorStyles.primary;

  Future<void> _startMeasurement() async {
    setState(() => _isLoading = true);

    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (mounted) {
        setState(() => _progress = i / 100);
      }
      if (i == 100) _navigateToResult();
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToResult() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(widget.UUID),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ProgressCircle(progress: _progress),
            const SizedBox(height: 40),
            SensorStatusCard(status: sensorStatus, color: sensorColor),
            const SizedBox(height: 50),
            ActionButton(
              isLoading: _isLoading,
              isCompleted: _progress >= 1.0,
              onNavigateToResult: _navigateToResult,
              onStartMeasurement: _startMeasurement,
            ),
          ],
        ),
      ),
    );
  }
}