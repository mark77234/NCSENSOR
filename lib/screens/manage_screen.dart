import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../widgets/common_tile.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  List<Map<String, dynamic>> users = [
    {"id": 1, "name": "김영희", "permission": "일반 사용자"},
    {"id": 2, "name": "이철수", "permission": "관리자"},
    {"id": 3, "name": "박지민", "permission": "일반 사용자"},
  ];

  void handleDelete(int userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("삭제 확인"),
        content: Text("정말로 이 사용자를 삭제하시겠습니까?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("취소"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                users.removeWhere((user) => user["id"] == userId);
              });
              Navigator.of(context).pop();
            },
            child: Text("삭제"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("사용자 관리", style: TextStyles.title),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: ContainerStyles.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Back Button and Title
            SizedBox(height: 16),
            // Admin Section
            CommonTile(
              label: "관리자",
              title: "홍길동",
            ),
            // Text(
            //   "관리자",
            //   style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            // ),
            // Container(
            //   margin: EdgeInsets.symmetric(vertical: 8),
            //   padding: EdgeInsets.all(12),
            //   decoration: BoxDecoration(
            //     color: Colors.grey[100],
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Text("홍길동"),
            // ),
            SizedBox(height: 16),
            // Users List
            Text(
              "사용자 목록",
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user["name"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              user["permission"],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => handleDelete(user["id"]),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red[500],
                          ),
                          splashRadius: 20,
                        ),
                      ],
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
