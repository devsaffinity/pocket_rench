import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Tappable icon with a minimum hit area and press animation. Pass either an
/// [IconData] or an SVG asset path from `AppIcons`.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.onPressed,
    super.key,
    this.icon,
    this.svgPath,
    this.color = AppColors.textPrimary,
    this.backgroundColor,
    this.size,
  }) : assert(
         (icon == null) != (svgPath == null),
         'Provide exactly one of icon or svgPath',
       );

  final IconData? icon;
  final String? svgPath;
  final VoidCallback? onPressed;
  final Color color;
  final Color? backgroundColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final iconSize = size ?? AppSizes.iconM;

    return TapScale(
      onTap: onPressed,
      haptic: true,
      child: Container(
        width: AppSizes.tapTarget,
        height: AppSizes.tapTarget,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: svgPath != null
            ? AppImage(
                svgPath!,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
                color: color,
              )
            : Icon(icon, color: color, size: iconSize),
      ),
    );
  }
}
