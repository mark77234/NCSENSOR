import 'package:NCSensor/storage/data/meta_storage.dart';
import 'package:flutter/material.dart';

import '../../models/meta/ncs_meta.dart';
import '../../widgets/screens/select/action_button.dart';
import '../../widgets/screens/select/dropdown.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  String selectedItem = '';
  String selectedBodyParts = '';
  String UUID = '';

  @override
  void initState() {
    super.initState();
    _initializeSelection();
  }

  // 초기 선택 항목 설정
  void _initializeSelection() {
    final uiData = UiStorage.data;

    setState(() {
      selectedItem = uiData.articles.first.name;
      UUID = uiData.articles.first.id;
    });
  }

  // 드롭다운 변경 핸들러
  void _handleDropdownChange(String newValue, String newUUID) {
    setState(() {
      selectedItem = newValue;
      selectedBodyParts = '';
      UUID = newUUID;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiData = UiStorage.data;
    return Scaffold(
      body: _buildContent(uiData),
    );
  }

  // 컨텐츠 빌더
  Widget _buildContent(NcsMetaData uiData) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Dropdown(
              articles: uiData.articles,
              selectedItem: selectedItem,
              onChanged: _handleDropdownChange,
            ),
            const SizedBox(height: 30),
            ActionButton(
              selectedItem: selectedItem,
              selectedBodyParts: selectedBodyParts,
              uuid: UUID,
            ),
          ],
        ),
      ),
    );
  }
}
