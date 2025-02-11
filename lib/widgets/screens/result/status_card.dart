import 'package:flutter/material.dart';

import '../../../models/ui/article_model.dart';

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
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "DoHyeon",
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(
                sections.length,
                    (index) =>
                    Padding(
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
                                  fontFamily: "DoHyeon",
                                ),
                              ),
                            ],
                          ),
                          Text(
                            sections[index].content,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4B5563),
                              fontFamily: "DoHyeon",
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
