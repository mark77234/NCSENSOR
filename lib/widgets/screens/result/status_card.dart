import 'package:NCSensor/constants/styles.dart';
import 'package:flutter/material.dart';

import '../../../models/meta/article_model.dart';

class StatusCard extends StatelessWidget {
  final List<Section> sections;
  final String title;

  const StatusCard({
    super.key,
    required this.sections,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerStyles.card,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: "Pretendard",
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(
              sections.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 5,
                          backgroundColor: sections[index].color,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          sections[index].name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF4B5563),
                            fontFamily: "Pretendard",
                          ),
                        ),
                      ],
                    ),
                    Text(
                      sections[index].content,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4B5563),
                        fontFamily: "Pretendard",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
