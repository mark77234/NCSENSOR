import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constants/styles.dart';
import '../../../models/data/user_model.dart';

class ProfilePicture extends StatelessWidget {
  final UserProfile data;
  final bool isEditing;
  final Function() onImagePick;
  static const double _profilePictureRadius = 48.0;
  static const double _editButtonRadius = 16.0;

  const ProfilePicture({
    super.key,
    required this.data,
    required this.isEditing,
    required this.onImagePick,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: _profilePictureRadius,
            backgroundColor: Colors.grey[200],
            backgroundImage: data.imagePath != null
                ? FileImage(File(data.imagePath!)) as ImageProvider
                : null,
            child: data.imagePath == null
                ? Icon(Icons.person,
                    size: _profilePictureRadius, color: Colors.grey)
                : null,
          ),
          if (isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: onImagePick,
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
}
