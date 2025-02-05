import 'package:NCSensor/providers/ui_data_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../models/ui/index.dart';
import '../../widgets/screens/select/bodypartGrid.dart';
import '../../widgets/screens/select/dropdown.dart';
import '../../widgets/screens/select/startButton.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uiDataProvider = context.read<UiDataProvider>();
      if (uiDataProvider.uiData?.articles.isNotEmpty ?? false) {
        setState(() {
          selectedItem = uiDataProvider.uiData!.articles.first.name;
          UUID = uiDataProvider.uiData!.articles.first.id;
        });
      }
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

  // 체취 부위 선택 핸들러
  void _handleSubtypeSelect(String subtypeName, String subtypeId) {
    setState(() {
      selectedBodyParts = subtypeName;
      UUID = subtypeId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiData = context.watch<UiDataProvider>().uiData;
    return Scaffold(
      body: _buildContent(uiData),
    );
  }

  // 컨텐츠 빌더
  Widget _buildContent(UiData? uiData) {
    if (uiData == null) return const Center(child: CircularProgressIndicator());

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
            if (selectedItem.isNotEmpty && _hasSubtypes(uiData))
              BodyPartGrid(
                selectedItem: selectedItem,
                selectedBodyParts: selectedBodyParts,
                uiData: uiData,
                onSubtypeSelected: _handleSubtypeSelect,
              ),
            const SizedBox(height: 30),
            StartMeasurementButton(
              selectedItem: selectedItem,
              selectedBodyParts: selectedBodyParts,
              uuid: UUID,
            ),
          ],
        ),
      ),
    );
  }
  bool _hasSubtypes(UiData uiData) {
    final article = uiData.articles.firstWhere(
          (article) => article.name == selectedItem,
    );
    return article.subtypes != null && article.subtypes!.isNotEmpty;
  }
}



