import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Fully rounded, content-sized button for secondary calls to action.
class AppPillButton extends StatelessWidget {
  const AppPillButton({
    required this.label,
    required this.onPressed,
    required this.height,
    required this.horizontalPadding,
    required this.textStyle,
    super.key,
    this.leading,
    this.color = AppColors.accent,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;
  final double horizontalPadding;
  final TextStyle textStyle;
  final Widget? leading;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onPressed,
      haptic: true,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ?leading,
            Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }
}
