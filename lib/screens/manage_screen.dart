import 'package:flutter/material.dart';
import 'package:taesung1/widgets/my_field.dart';

import '../constants/styles.dart';
import '../widgets/sm_tile.dart';

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
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with Back Button and Title
            SizedBox(height: 16),
            // Admin Section
            MyField(label: "관리자", widget: SmTile(title: "홍길동")),
            SizedBox(height: 16),
            MyField(
                label: "사용자목록",
                widget: ListView.separated(
                  itemCount: users.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return SmTile(
                        title: user["name"],
                        subtitle: user["permission"],
                        actionIcon: Icons.delete_outline,
                        onAction: () => handleDelete(user["id"]));
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 12),
                ))
          ],
        ),
      ),
    );
  }
}
