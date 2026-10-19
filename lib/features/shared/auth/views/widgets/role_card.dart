import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Selectable card describing one way to use the app.
class RoleCard extends StatelessWidget {
  const RoleCard({
    required this.iconPath,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String iconPath;
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.roleCardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          border: Border.all(
            color: isSelected ? AppColors.accent : AppColors.transparent,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: AppDurations.fast,
              width: AppSizes.roleIconCircle,
              height: AppSizes.roleIconCircle,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.accent : AppColors.surfaceIcon,
              ),
              child: AppImage(
                iconPath,
                width: AppSizes.roleIconSize,
                height: AppSizes.roleIconSize,
                fit: BoxFit.contain,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppSizes.roleCardIconTitleGap),
            Text(title, style: AppTextStyles.cardTitle),
            SizedBox(height: AppSizes.roleCardTitleDescGap),
            Text(description, style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
