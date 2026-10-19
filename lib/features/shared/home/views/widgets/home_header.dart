import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Avatar, greeting and notifications button.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.name,
    required this.avatar,
    required this.onBellTap,
    super.key,
  });

  final String name;

  /// Network URL of the profile photo.
  final String avatar;
  final VoidCallback onBellTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          avatar,
          width: AppSizes.homeAvatar,
          height: AppSizes.homeAvatar,
          borderRadius: BorderRadius.circular(AppSizes.homeAvatar),
        ),
        SizedBox(width: AppSizes.homeAvatarGap),
        Expanded(
          child: SizedBox(
            height: AppSizes.homeAvatar,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.welcomeBack, style: AppTextStyles.greeting),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.itemTitle.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        TapScale(
          onTap: onBellTap,
          haptic: true,
          child: Container(
            width: AppSizes.homeBellBox,
            height: AppSizes.homeBellBox,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: AppImage(
              AppIcons.bell,
              width: AppSizes.homeBellIcon,
              height: AppSizes.homeBellIcon,
              fit: BoxFit.contain,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }
}
