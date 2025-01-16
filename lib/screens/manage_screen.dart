import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../models/user_model.dart';
import '../widgets/common/my_field.dart';
import '../widgets/common/sm_tile.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  List<UserPermission> users = [
    UserPermission(id: 1, name: "김영희", permission: "일반 사용자"),
    UserPermission(id: 2, name: "이철수", permission: "관리자"),
    UserPermission(id: 3, name: "박지민", permission: "일반 사용자"),
  ];

  void handleDelete(int userId) {
    _showDeleteConfirmDialog(userId);
  }

  void _showDeleteConfirmDialog(int userId) {
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
            onPressed: () => _deleteUser(userId),
            child: Text("삭제"),
          ),
        ],
      ),
    );
  }

  void _deleteUser(int userId) {
    setState(() {
      users.removeWhere((user) => user.id == userId);
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("사용자 관리"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: ContainerStyles.card,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            _buildAdminSection(),
            SizedBox(height: 16),
            _buildUserList(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminSection() {
    return MyField(
      label: "관리자",
      widget: SmTile(title: "홍길동"),
    );
  }

  Widget _buildUserList() {
    return MyField(
      label: "사용자목록",
      widget: ListView.separated(
        itemCount: users.length,
        shrinkWrap: true,
        itemBuilder: _buildUserListItem,
        separatorBuilder: (_, __) => SizedBox(height: 12),
      ),
    );
  }

  Widget _buildUserListItem(BuildContext context, int index) {
    final user = users[index];
    return SmTile(
      title: user.name,
      subtitle: user.permission,
      actionIcon: Icons.delete_outline,
      onAction: () => handleDelete(user.id),
    );
  }
}
