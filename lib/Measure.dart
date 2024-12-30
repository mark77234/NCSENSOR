import 'package:flutter/material.dart';

class Measure extends StatelessWidget {
  const Measure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("측정"),
      ),
      body: const Center(
        child: Text(
          '측정화면',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}