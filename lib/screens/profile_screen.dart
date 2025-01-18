import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taesung1/routes/app_routes.dart';

import '../constants/styles.dart';
import '../models/user_model.dart';
import '../widgets/common/editable_field.dart';
import '../widgets/common/my_header.dart';

// 프로필 화면
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const double _profilePictureRadius = 48.0;
  static const double _editButtonRadius = 16.0;

  bool isEditing = false;
  late UserProfile userData;
  late UserProfile visibleData;

  @override
  void initState() {
    super.initState();
    userData = UserProfile(
      name: "홍길동",
      phone: "010-1234-5678",
      email: "example@email.com",
    );
    visibleData = userData;
  }

  Future<void> _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          visibleData = visibleData.copyWith(imagePath: image.path);
        });
      }
    } catch (e) {
      _showErrorDialog("이미지를 불러오는데 실패했습니다.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("오류"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("확인"),
          ),
        ],
      ),
    );
  }

  void handleEdit() {
    setState(() {
      isEditing = true;
      visibleData = userData;
    });
  }

  void handleSave() {
    setState(() {
      isEditing = false;
      userData = visibleData;
    });
  }

  void handleCancel() {
    setState(() {
      isEditing = false;
      visibleData = userData;
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
            MyHeader(title: "프로필"),
            _buildProfileCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: ContainerStyles.card,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildProfilePicture(),
          SizedBox(height: 16),
          _buildProfileFields(),
          SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: _profilePictureRadius,
            backgroundColor: Colors.grey[200],
            backgroundImage: visibleData.imagePath != null
                ? FileImage(File(visibleData.imagePath!)) as ImageProvider
                : null,
            child: visibleData.imagePath == null
                ? Icon(Icons.person,
                size: _profilePictureRadius, color: Colors.grey)
                : null,
          ),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  backgroundColor: ColorStyles.primary,
                  radius: _editButtonRadius,
                  child: Icon(Icons.camera_alt,
                      size: _editButtonRadius, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProfileFields() {
    return Column(
      children: [
        EditableField(
          label: "이름",
          value: visibleData.name,
          isEditing: isEditing,
          onChanged: (value) => visibleData = visibleData.copyWith(name: value),
        ),
        EditableField(
          label: "전화번호",
          value: visibleData.phone,
          isEditing: isEditing,
          keyboardType: TextInputType.phone,
          onChanged: (value) =>
          visibleData = visibleData.copyWith(phone: value),
        ),
        EditableField(
          label: "이메일",
          value: visibleData.email,
          isEditing: isEditing,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) =>
          visibleData = visibleData.copyWith(email: value),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return isEditing
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
    );
  }
}
