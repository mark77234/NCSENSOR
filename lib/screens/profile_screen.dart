import 'package:flutter/material.dart';

import '../constants/styles.dart';
import '../widgets/editable_field.dart';
import 'manage_screen.dart';


// 프로필 화면
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;
  Map<String, String> userInfo = {
    "name": "홍길동",
    "contact": "010-1234-5678",
    "email": "hong@example.com",
  };

  final bool isAdmin = true;

  void handleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void handleChange(String field, String value) {
    setState(() {
      userInfo[field] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            _buildProfilePicture(),
            SizedBox(height: 16),
            EditableField(
              label: "이름",
              value: userInfo["name"]!,
              isEditing: isEditing,
              onChanged: (value) => handleChange("name", value),
            ),
            EditableField(
              label: "연락처",
              value: userInfo["contact"]!,
              isEditing: isEditing,
              onChanged: (value) => handleChange("contact", value),
            ),
            EditableField(
              label: "이메일",
              value: userInfo["email"]!,
              isEditing: isEditing,
              onChanged: (value) => handleChange("email", value),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: handleEdit,
              icon: Icon(Icons.edit, color: Colors.white),
              label: Text(isEditing ? "저장하기" : "수정하기"),
              style: ButtonStyles.elevated,
            ),
            SizedBox(height: 12),
            if (isAdmin)
              OutlinedButton.icon(
                onPressed: () {
                  //push manage screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ManageScreen()),
                  );
                },
                icon: Icon(Icons.group, color: Color(0xFF2C46BD)),
                label: Text("사용자 관리"),
                style: ButtonStyles.outlined,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person, size: 48, color: Colors.grey),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // Handle camera action
              },
              child: CircleAvatar(
                backgroundColor: Color(0xFF2C46BD),
                radius: 16,
                child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}