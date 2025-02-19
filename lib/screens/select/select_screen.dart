import 'package:NCSensor/storage/data/meta_storage.dart';
import 'package:flutter/material.dart';

import '../../models/meta/ncs_meta.dart';
import 'widgets/action_button.dart';
import 'widgets/dropdown.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  String selectedItem = '';
  String selectedBodyParts = '';
  String UUID = '';
  NcsMetaData metaData = UiStorage.data;

  @override
  void initState() {
    super.initState();
    _initializeSelection();
  }

  // 초기 선택 항목 설정
  void _initializeSelection() {
    setState(() {
      selectedItem = metaData.articles.first.name;
      UUID = metaData.articles.first.id;
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
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Dropdown(
            articles: metaData.articles,
            selectedItem: selectedItem,
            onChanged: _handleDropdownChange,
          ),
          ActionButton(
            selectedItem: selectedItem,
            selectedBodyParts: selectedBodyParts,
            uuid: UUID,
          ),
        ],
      ),
    ));
  }
}
