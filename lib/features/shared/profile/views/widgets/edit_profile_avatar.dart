import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Initials in a circle with a camera badge for changing the photo.
class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({
    required this.initials,
    required this.onChangePhoto,
    super.key,
  });

  final String initials;
  final VoidCallback onChangePhoto;

  @override
  Widget build(BuildContext context) {
    final ring = AppSizes.editBadgeRing;
    final inset = AppSizes.editBadgeInset - ring;

    return SizedBox(
      width: AppSizes.editAvatar,
      height: AppSizes.editAvatar,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: AppSizes.editAvatar,
            height: AppSizes.editAvatar,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
            ),
            child: Text(initials, style: AppTextStyles.initials),
          ),
          Positioned(
            right: inset,
            bottom: inset,
            child: TapScale(
              onTap: onChangePhoto,
              haptic: true,
              child: Container(
                width: AppSizes.editBadge + ring * 2,
                height: AppSizes.editBadge + ring * 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.logoAccent,
                  border: Border.all(color: AppColors.background, width: ring),
                ),
                child: AppImage(
                  AppIcons.cameraFilled,
                  width: AppSizes.editBadgeIcon,
                  height: AppSizes.editBadgeIcon,
                  fit: BoxFit.contain,
                  color: AppColors.onLime,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
