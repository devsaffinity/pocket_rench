import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';

/// A number with its caption, on a card.
class ActivityStatCard extends StatelessWidget {
  const ActivityStatCard({required this.value, required this.label, super.key});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.mechStatHeight,
      padding: EdgeInsets.fromLTRB(
        AppSizes.mechStatPadding,
        AppSizes.mechStatPaddingTop,
        AppSizes.mechStatPadding,
        AppSizes.mechStatPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: AppTextStyles.activityNumber),
          SizedBox(height: AppSizes.mechStatNumberLabelGap),
          Text(label, style: AppTextStyles.activityLabel),
        ],
      ),
    );
  }
}
