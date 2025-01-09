import 'package:flutter/material.dart';
import 'package:taesung1/routes/app_routes.dart';

import '../constants/styles.dart';
import '../widgets/editable_tile.dart';

// 프로필 화면
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  Map<String, String> userData = {
    "name": "홍길동",
    "phone": "010-1234-5678",
    "email": "example@email.com",
  };

  Map<String, String> visibleData = {};

  @override
  void initState() {
    super.initState();
    visibleData = Map<String, String>.from(userData);
  }

  void handleEdit() {
    setState(() {
      isEditing = true;
      visibleData = Map<String, String>.from(userData);
    });
  }

  void handleSave() {
    setState(() {
      isEditing = false;
      userData = Map<String, String>.from(visibleData);
    });
  }

  void handleCancel() {
    setState(() {
      isEditing = false;
      visibleData = Map<String, String>.from(userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16),
          Center(child: Text("프로필", style: TextStyles.title)),
          SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: ContainerStyles.card,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildProfilePicture(isEditing),
                SizedBox(height: 16),
                EditableTile(
                  label: "이름",
                  value: userData["name"]!,
                  isEditing: isEditing,
                  onChanged: (value) => visibleData["name"] = value,
                ),
                EditableTile(
                  label: "전화번호",
                  value: userData["phone"]!,
                  isEditing: isEditing,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => visibleData["phone"] = value,
                ),
                EditableTile(
                  label: "이메일",
                  value: userData["email"]!,
                  isEditing: isEditing,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => visibleData["email"] = value,
                ),
                SizedBox(height: 16),
                isEditing
                    ? Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: handleCancel,
                              style: ButtonStyles.outlined,
                              child: Text("취소하기"),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: handleSave,
                              style: ButtonStyles.elevated,
                              child: Text("저장하기"),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          ElevatedButton(
                            onPressed: handleEdit,
                            style: ButtonStyles.outlined,
                            child: Text("수정하기"),
                          ),
                          SizedBox(height: 8),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.manage);
                            },
                            style: ButtonStyles.elevated,
                            icon: Icon(Icons.group),
                            label: Text("사용자 관리"),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildProfilePicture(bool isEditing) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.grey[200],
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150&h=150&fit=crop'),
            // child: Icon(Icons.person, size: 48, color: Colors.grey),
          ),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  //   pick image
                },
                child: CircleAvatar(
                  backgroundColor: ColorStyles.primary,
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
