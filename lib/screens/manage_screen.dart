
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/styles.dart';


class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  String adminName = "홍길동";

  // 사용자 목록 데이터
  List<Map<String, String>> users = [
    {"name": "전민지", "role": "일반사용자"},
    {"name": "김태민", "role": "일반사용자"},
    {"name": "이병찬", "role": "일반사용자"},
  ];

  // 사용자 삭제 함수
  void deleteUser(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사용자 관리',style: TextStyles.title,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 관리자 이름
            Text(
              "관리자: $adminName",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // 사용자 목록
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.only(bottom: 12),
                    color: Colors.grey[100],
                    child: ListTile(
                      title: Text(
                        user["name"]!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("권한: ${user["role"]}"),
                      trailing: ElevatedButton(
                        onPressed: () => deleteUser(index),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text("삭제", style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}