import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_gradients.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';

/// Brand-gradient circle with a white icon in the middle.
class GradientCircleIcon extends StatelessWidget {
  const GradientCircleIcon({
    required this.iconPath,
    required this.diameter,
    required this.iconSize,
    super.key,
  });

  final String iconPath;
  final double diameter;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppGradients.brand,
      ),
      child: AppImage(
        iconPath,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
        color: AppColors.white,
      ),
    );
  }
}
