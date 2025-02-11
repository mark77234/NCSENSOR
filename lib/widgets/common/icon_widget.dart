import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWidget extends StatelessWidget {
  final String icon;
  final double size;

  const IconWidget({
    super.key,
    required this.icon,
    this.size = 40,
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
          width: size,
          height: size,
          errorBuilder: (_, __, ___) => _buildDefaultIcon(),
        );
      }
      return SvgPicture.asset(
        'assets/icons/$icon',
        width: size,
        height: size,
        errorBuilder: (_, __, ___) => _buildDefaultIcon(),
      );
    } catch (e) {
      return _buildDefaultIcon();
    }
  }

  Widget _buildDefaultIcon() {
    return SvgPicture.asset(
      'assets/icons/measure.svg',
      width: size,
      height: size,
    );
  }
} 