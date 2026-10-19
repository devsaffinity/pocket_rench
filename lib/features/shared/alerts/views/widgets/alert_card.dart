import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/alerts/data/models/alert_item.dart';

/// A notification: a bell in a circle, a title and a message. Unread alerts
/// have a lime bell and a lime dot.
class AlertCard extends StatelessWidget {
  const AlertCard({required this.alert, required this.onTap, super.key});

  final AlertItem alert;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.alertCardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Row(
          children: [
            Container(
              width: AppSizes.alertIconCircle,
              height: AppSizes.alertIconCircle,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
              ),
              child: AppImage(
                AppIcons.bell,
                width: AppSizes.alertIcon,
                height: AppSizes.alertIcon,
                fit: BoxFit.contain,
                color: alert.isUnread
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
            ),
            SizedBox(width: AppSizes.alertIconTextGap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(alert.title, style: AppTextStyles.alertTitle),
                  SizedBox(height: AppSizes.alertTitleBodyGap),
                  Text(alert.body, style: AppTextStyles.alertBody),
                ],
              ),
            ),
            if (alert.isUnread) ...[
              SizedBox(width: AppSizes.alertDotGap),
              Container(
                width: AppSizes.alertDot,
                height: AppSizes.alertDot,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.logoAccent,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
