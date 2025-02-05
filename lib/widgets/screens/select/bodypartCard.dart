import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/styles.dart';
import '../../../models/ui/article_model.dart';

class BodyPartCard extends StatelessWidget {
  final Subtype subtype;
  final bool isSelected;
  final VoidCallback onTap;

  const BodyPartCard({
    super.key,
    required this.subtype,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyles.background,
          border:
              Border.all(color: isSelected ? ColorStyles.primary : ColorStyles.lightgrey),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/${subtype.icon}'),
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
}
