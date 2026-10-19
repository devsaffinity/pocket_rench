import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';

/// A highlighted number with a caption.
class StatCard extends StatelessWidget {
  const StatCard({required this.value, required this.label, super.key});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSizes.statCardPaddingH,
        AppSizes.statCardPaddingTop,
        AppSizes.statCardPaddingH,
        AppSizes.statCardPaddingBottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$value', style: AppTextStyles.statNumber),
          Text(label, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }
}
