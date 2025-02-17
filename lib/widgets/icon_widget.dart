import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWidget extends StatelessWidget {
  final String icon;
  final double width;
  final double height;
  final defaultIcon;

  const IconWidget({
    super.key,
    required this.icon,
    this.width = 40,
    this.height = 40,
    this.defaultIcon = 'measure.svg',
  });

  @override
  Widget build(BuildContext context) {
    return _buildIcon();
  }

  Widget _buildIcon() {
    try {
      if (icon.startsWith('http')) {
        return Image.network(
          icon,
          width: width,
          height: height,
          errorBuilder: (_, __, ___) => _buildDefaultIcon(),
        );
      }
      return SvgPicture.asset(
        'assets/icons/$icon',
        width: width,
        height: height,
        errorBuilder: (_, __, ___) => _buildDefaultIcon(),
      );
    } catch (e) {
      return _buildDefaultIcon();
    }
  }

  Widget _buildDefaultIcon() {
    return SvgPicture.asset(
      'assets/icons/$defaultIcon',
      width: 40,
      height: 40,
    );
  }
}
