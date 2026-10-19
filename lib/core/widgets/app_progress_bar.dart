import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_gradients.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';

/// Rounded bar filled with the brand gradient, with its percentage label to
/// the right. [fill] is the share of the bar to paint (0 to 1).
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({required this.fill, required this.label, super.key});

  final double fill;
  final String label;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppSizes.progressBarHeight / 2);

    return Row(
      children: [
        Expanded(
          child: Container(
            height: AppSizes.progressBarHeight,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: radius,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: fill.clamp(0, 1)),
                duration: AppDurations.entry,
                curve: AppDurations.standardCurve,
                builder: (context, value, _) => FractionallySizedBox(
                  widthFactor: value,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppGradients.brand,
                      borderRadius: radius,
                    ),
                    child: SizedBox(height: AppSizes.progressBarHeight),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.progressTextGap),
        Text(label, style: AppTextStyles.progressLabel),
      ],
    );
  }
}
