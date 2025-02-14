import 'package:flutter/material.dart';

import '../../../models/data/user_model.dart';
import '../../../widgets/editable_field.dart';

class ProfileFields extends StatelessWidget {
  final UserProfile data;
  final bool isEditing;
  final Function(UserProfile) onDataChange;

  const ProfileFields({
    super.key,
    required this.data,
    required this.isEditing,
    required this.onDataChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditableField(
          label: "이름",
          value: data.name,
          isEditing: isEditing,
          onChanged: (value) => onDataChange(data.copyWith(name: value)),
        ),
        EditableField(
          label: "전화번호",
          value: data.phone,
          isEditing: isEditing,
          keyboardType: TextInputType.phone,
          onChanged: (value) => onDataChange(data.copyWith(phone: value)),
        ),
        EditableField(
          label: "이메일",
          value: data.email,
          isEditing: isEditing,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => onDataChange(data.copyWith(email: value)),
        ),
      ],
    );
  }
}
