import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_pill_button.dart';

/// Upload card with format hints and a "Browse Files" button.
class PhotoDropZone extends StatelessWidget {
  const PhotoDropZone({required this.onBrowse, super.key});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: AppSizes.uploadCardPaddingV),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppImage(
            AppIcons.uploadCloud,
            width: AppSizes.uploadIconSize,
            height: AppSizes.uploadIconSize,
            fit: BoxFit.contain,
            color: AppColors.textMuted,
          ),
          SizedBox(height: AppSizes.uploadIconTitleGap),
          Text(AppStrings.dropTitle, style: AppTextStyles.dropTitle),
          SizedBox(height: AppSizes.uploadTitleCaptionGap),
          Text(
            AppStrings.dropFormats,
            textAlign: TextAlign.center,
            style: AppTextStyles.dropCaption,
          ),
          Text(
            AppStrings.dropMaxSize,
            textAlign: TextAlign.center,
            style: AppTextStyles.dropCaption,
          ),
          SizedBox(height: AppSizes.uploadCaptionButtonGap),
          AppPillButton(
            label: AppStrings.browseFiles,
            onPressed: onBrowse,
            height: AppSizes.pillSmallHeight,
            horizontalPadding: AppSizes.pillSmallPaddingH,
            textStyle: AppTextStyles.pillSmall.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
