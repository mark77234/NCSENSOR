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
                if (selectedItem.isNotEmpty && _hasSubtypes(uiData))
                  _buildBodyPartsSelection(uiData),
                const SizedBox(height: 20),
                _buildStart()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(UiData uiData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 250,
          height: 60,
          color: ColorStyles.background,
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
                child: Material(
                  color: ColorStyles.background,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/${article.icon}',
                        height: 40,
                        width: 40,
                        placeholderBuilder: (BuildContext context) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            article.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                            ),
                          ),
                          Text(
                            article.content,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            underline: const SizedBox(),
            dropdownColor: ColorStyles.background,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
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

  // Widget _buildBodyPartsSelection(UiData uiData) {
  //   final selectedArticle = uiData.articles.firstWhere(
  //     (article) => article.name == selectedItem,
  //   );
  //
  //   return Column(
  //     children: [
  //       const SizedBox(height: 40),
  //       const Text(
  //         "측정 부위를 선택해주세요",
  //         style: TextStyle(
  //           color: Colors.grey,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 16,
  //         ),
  //       ),
  //       const SizedBox(height: 30),
  //       Column(
  //         children: [
  //           for (var subtype in selectedArticle.subtypes!)
  //             Padding(
  //               padding: const EdgeInsets.only(bottom: 10),
  //               child: ElevatedButton(
  //                 style: selectedBodyParts == subtype.name
  //                     ? ButtonStyles.primaryOutlined
  //                     : ButtonStyles.greyOutlined,
  //                 onPressed: () {
  //                   setState(() {
  //                     selectedBodyParts = subtype.name;
  //                     UUID = subtype.id;
  //                   });
  //                 },
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     SvgPicture.asset(
  //                       'assets/icons/${subtype.icon}',
  //                       height: 40,
  //                       width: 40,
  //                     ),
  //                     const SizedBox(width: 12),
  //                     Column(
  //                       children: [
  //                         Text(
  //                           subtype.name,
  //                           style: const TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                         const SizedBox(height: 5),
  //                         Text(
  //                           subtype.content,
  //                           style: const TextStyle(
  //                             fontSize: 12,
  //                             color: Colors.grey,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? ColorStyles.primary : Colors.grey.shade300,
            width: 1.5,
          ),
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
        minimumSize: const Size(300, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
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
