import 'package:NCSensor/routes/app_routes.dart';
import 'package:NCSensor/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/styles.dart';
import '../../models/data/user_model.dart';
import '../../utils/api_hook.dart';
import '../../widgets/api_state_builder.dart';
import '../../widgets/error_dialog.dart';
import 'widgets/profile_fields.dart';
import 'widgets/profile_picture.dart';

// 프로필 화면
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ApiHook<UserProfile> profileHook;
  bool isEditing = false;
  UserProfile? editingData;

  @override
  void initState() {
    super.initState();
    profileHook = ApiHook<UserProfile>(
      apiCall: ApiService.user.getUserProfile,
      onError: (err) => print(err),
    );
    profileHook.addListener(() {
      setState(() {});
    });
  }

  Future<void> _pickImage() async {
    if (!isEditing) return;
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          editingData = editingData!.copyWith(imagePath: image.path);
        });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                errorMessage: e.toString(),
              ));
    }
  }

  void _handleEdit() {
    setState(() {
      editingData = profileHook.state.data;
      isEditing = true;
    });
  }

  void _handleCancel() {
    setState(() {
      isEditing = false;
      editingData = null;
    });
  }

  Future<void> _handleSave() async {
    // api 호출
    // final response = await ApiService.user.updateProfile(editingData!);
    setState(() {
      isEditing = false;
      editingData = null;
    });
    profileHook.state.reFetch();
  }

  @override
  void dispose() {
    profileHook.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ApiStateBuilder(
                apiState: profileHook.state,
                title: "프로필",
                builder: (context, data) {
                  return _buildProfileCard(isEditing ? editingData! : data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(UserProfile data) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: ContainerStyles.card,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfilePicture(
            data: data,
            isEditing: isEditing,
            onImagePick: _pickImage,
          ),
          SizedBox(height: 16),
          ProfileFields(
            data: data,
            isEditing: isEditing,
            onDataChange: (newData) {
              if (isEditing) {
                setState(() => editingData = newData);
              }
            },
          ),
          SizedBox(height: 16),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return isEditing
        ? Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleCancel,
                  style: ButtonStyles.primaryExpandOutlined,
                  child: Text("취소하기"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: _handleSave,
                  style: ButtonStyles.primaryExpandElevated,
                  child: Text("저장하기"),
                ),
              ),
            ],
          )
        : Column(
            children: [
              ElevatedButton(
                onPressed: _handleEdit,
                style: ButtonStyles.primaryExpandOutlined,
                child: Text("수정하기"),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.manage),
                style: ButtonStyles.primaryExpandElevated,
                icon: Icon(Icons.group),
                label: Text("사용자 관리"),
              ),
            ],
          );
  }
}
