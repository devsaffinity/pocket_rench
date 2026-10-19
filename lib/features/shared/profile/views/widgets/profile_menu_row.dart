import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// One tappable card in the Profile menu: icon box, title and chevron.
class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({
    required this.iconPath,
    required this.title,
    required this.onTap,
    super.key,
    this.isCompact = false,
    this.showsVerifiedBadge = false,
    this.isDestructive = false,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;

  /// A slightly shorter card.
  final bool isCompact;

  /// Shows the verified badge after the title.
  final bool showsVerifiedBadge;

  /// Draws the title and icon in the error color and drops the chevron.
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        height: isCompact
            ? AppSizes.accountRowHeightCompact
            : AppSizes.accountRowHeight,
        padding: EdgeInsets.only(
          left: AppSizes.accountRowPadding,
          right: AppSizes.accountRowTrailing,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Row(
          children: [
            Container(
              width: AppSizes.accountRowIconBox,
              height: AppSizes.accountRowIconBox,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(
                  AppSizes.accountRowIconBoxRadius,
                ),
              ),
              child: AppImage(
                iconPath,
                width: AppSizes.accountRowIcon,
                height: AppSizes.accountRowIcon,
                fit: BoxFit.contain,
                color: isDestructive
                    ? AppColors.error
                    : AppColors.textSecondary,
              ),
            ),
            SizedBox(width: AppSizes.accountRowIconTitleGap),
            Text(
              title,
              style: isDestructive
                  ? AppTextStyles.menuTitle.copyWith(color: AppColors.error)
                  : AppTextStyles.menuTitle,
            ),
            if (showsVerifiedBadge) ...[
              SizedBox(width: AppSizes.accountBadgeGap),
              AppImage(
                AppIcons.verified,
                width: AppSizes.accountBadge,
                height: AppSizes.accountBadge,
                fit: BoxFit.contain,
              ),
            ],
            const Spacer(),
            if (!isDestructive)
              AppImage(
                AppIcons.chevronRight,
                width: AppSizes.accountChevron,
                height: AppSizes.accountChevron,
                fit: BoxFit.contain,
                color: AppColors.chevron,
              ),
          ],
        ),
      ),
    );
  }
}
