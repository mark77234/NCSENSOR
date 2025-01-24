import 'package:flutter/material.dart';
import 'package:NCSensor/screens/measure/measure_screen.dart';
import '../../constants/styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:NCSensor/services/api_service.dart';
import 'package:NCSensor/models/aritcle_model.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  bool _isLabelLoading = false;
  String selectedItem = '';
  String selectedBodyParts = '';
  String UUID = '';
  ArticleData? articledata;

  @override
  void initState() {
    super.initState();
    _loadArticleData();
  }

  Future<void> _loadArticleData() async {
    setState(() {
      _isLabelLoading = true;
    });
    try {
      final data = await ApiService.getArticleData();
      setState(() {
        articledata = data;
      });
    } catch (e) {
      print('Error loading measure labels: $e');
    }
    setState(() {
      _isLabelLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              if (_isLabelLoading)
                const CircularProgressIndicator()
              else if (articledata == null || articledata!.articles.isEmpty)
                _buildEmptyState()
              else
                Column(
                  children: [
                    _buildDropdown(),
                    if (selectedItem.isNotEmpty &&
                        _hasSubtypes(selectedItem))
                      _buildBodyPartsSelection(),
                  ],
                ),
              const SizedBox(height: 20),
              _buildStart()
            ],
          ),
        ),
      ),
    );
  }

  // Dropdown UI
  Widget _buildDropdown() {
    final firstArticle = articledata!.articles
        .firstWhere(
            (article) => article.subtypes == null || article.subtypes!.isEmpty,
        orElse: () => articledata!.articles.first);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 150,
          height: 60,
          color: ColorStyles.background,
          child: DropdownButton<String>(
            value: selectedItem.isEmpty ? firstArticle.name : selectedItem,
            onChanged: (newValue) {
              setState(() {
                selectedItem = newValue!;
                selectedBodyParts = '';
                UUID = firstArticle.id;
              });
            },
            items: articledata!.articles.map<DropdownMenuItem<String>>((article) {
              return DropdownMenuItem<String>(
                value: article.name,
                child: Material(
                  color: ColorStyles.background,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/${_getIconFortype(article.name)}.svg',
                        height: 40,
                        width: 40,
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
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '${article.name} 측정',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            underline: SizedBox(),
            dropdownColor: ColorStyles.background,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }

  // Check if selected item has subtypes
  bool _hasSubtypes(String selectedItem) {
    final article = articledata!.articles
        .firstWhere((article) => article.name == selectedItem);
    return article.subtypes != null && article.subtypes!.isNotEmpty;
  }

  // Body parts selection UI
  Widget _buildBodyPartsSelection() {
    final selectedArticle = articledata!.articles
        .firstWhere((article) => article.name == selectedItem);

    return Column(
      children: [
        const SizedBox(height: 40),
        const Center(
          child: Text(
            "측정 부위를 선택해주세요",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            for (var subtype in selectedArticle.subtypes!)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: selectedBodyParts == subtype.name
                      ? ButtonStyles.primaryOutlined
                      : ButtonStyles.greyOutlined,
                  onPressed: () {
                    setState(() {
                      selectedBodyParts = subtype.name;
                      UUID = subtype.id;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/${_getIconForSubtype(subtype.name)}.svg',
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        children: [
                          Text(
                            subtype.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${subtype.name} 악취 측정',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  // Get icon for subtype
  String _getIconForSubtype(String name) {
    switch (name) {
      case '입냄새':
        return "mouth";
      case '발냄새':
        return 'foot';
      case '겨드랑이냄새':
        return 'armpit';
      default:
        return 'default';
    }
  }

  // Get icon for type
  String _getIconFortype(String name) {
    switch (name) {
      case '체취':
        return "body";
      case '음주':
        return 'drinking';
      default:
        return 'default';
    }
  }

  // Empty state widget
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.error,
            size: 48,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "데이터를 가져오는데 오류가 발생했습니다",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Start button widget
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
          _navigate(context);
        }
      },
      child: const Text(
        '측정 시작',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Navigate to next screen
  Future<void> _navigate(BuildContext context) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MeasureScreen(UUID),
      ),
    );
  }

  // Show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}