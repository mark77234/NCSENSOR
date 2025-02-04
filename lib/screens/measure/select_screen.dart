import 'package:NCSensor/providers/ui_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:NCSensor/screens/measure/measure_screen.dart';
import 'package:provider/provider.dart';
import '../../constants/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/ui/article_model.dart';
import '../../models/ui/index.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uiDataProvider =
          Provider.of<UiDataProvider>(context, listen: false);
      if (uiDataProvider.uiData != null &&
          uiDataProvider.uiData!.articles.isNotEmpty) {
        setState(() {
          selectedItem = uiDataProvider.uiData!.articles.first.name;
          UUID = uiDataProvider.uiData!.articles.first.id;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final uiDataProvider = Provider.of<UiDataProvider>(context);
    final uiData = uiDataProvider.uiData;

    if (uiData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                _buildDropdown(uiData),
                const SizedBox(height: 30),
                if (selectedItem.isNotEmpty && _hasSubtypes(uiData))
                  _buildBodyPartsSelection(uiData),
                const SizedBox(height: 30),
                _buildStart()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(UiData uiData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            '측정 항목 선택',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: ColorStyles.background,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedItem.isEmpty
                  ? uiData.articles.first.name
                  : selectedItem,
              onChanged: (newValue) {
                final selectedArticle = uiData.articles.firstWhere(
                      (article) => article.name == newValue,
                );
                setState(() {
                  selectedItem = newValue!;
                  selectedBodyParts = '';
                  UUID = selectedArticle.id;
                });
              },
              items: uiData.articles.map<DropdownMenuItem<String>>((article) {
                return DropdownMenuItem<String>(
                  value: article.name,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/${article.icon}',
                          height: 40,
                          width: 40,
                          placeholderBuilder: (BuildContext context) =>
                          const Icon(Icons.error, size: 40),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                article.content,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              icon: const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.arrow_drop_down, size: 28, color: ColorStyles.primary,),
              ),
              isExpanded: true,
              dropdownColor: ColorStyles.background,
              borderRadius: BorderRadius.circular(8.0),
              elevation: 4,
              menuMaxHeight: 400,
              itemHeight: 80,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              selectedItemBuilder: (BuildContext context) {
                return uiData.articles.map<Widget>((Article article) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/${article.icon}',
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              article.content,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ],
    );
  }

  bool _hasSubtypes(UiData uiData) {
    final article = uiData.articles.firstWhere(
      (article) => article.name == selectedItem,
    );
    return article.subtypes != null && article.subtypes!.isNotEmpty;
  }


  Widget _buildBodyPartsSelection(UiData uiData) {
    final selectedArticle = uiData.articles.firstWhere(
          (article) => article.name == selectedItem,
    );

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.6,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        for (var subtype in selectedArticle.subtypes!)
          _buildBodyPartCard(subtype),
      ],
    );
  }

  Widget _buildBodyPartCard(Subtype subtype) {
    final isSelected = selectedBodyParts == subtype.name;

    return InkWell(
      onTap: () {
        setState(() {
          selectedBodyParts = subtype.name;
          UUID = subtype.id;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: ColorStyles.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? ColorStyles.primary : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/${subtype.icon}',
            ),
            const SizedBox(height: 12),
            Text(
              subtype.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtype.content,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStart() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorStyles.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(400, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        if (selectedItem.isEmpty) {
          _showErrorDialog(context, '먼저 음주 또는 체취 항목을 선택하세요.');
        } else if (selectedItem == '체취' && selectedBodyParts.isEmpty) {
          _showErrorDialog(context, '체취 부위를 선택해 주세요.');
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MeasureScreen(UUID),
            ),
          );
        }
      },
      child: const Text(
        '측정 시작',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('필수 선택', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인', style: TextStyle(color: ColorStyles.primary)),
          ),
        ],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
