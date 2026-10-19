import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_pill_button.dart';

/// Upload card for credential documents, with format hints and a
/// "Browse Files" button.
class DocumentDropZone extends StatelessWidget {
  const DocumentDropZone({required this.onBrowse, super.key});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: AppSizes.onbDropPaddingTop,
        bottom: AppSizes.onbDropPaddingBottom,
      ),
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
          SizedBox(height: AppSizes.onbDropIconTitleGap),
          Text(AppStrings.docDropTitle, style: AppTextStyles.onbDropTitle),
          SizedBox(height: AppSizes.onbDropTitleCaptionGap),
          Text(
            AppStrings.docDropFormats,
            textAlign: TextAlign.center,
            style: AppTextStyles.onbDropCaption,
          ),
          Text(
            AppStrings.docDropMaxSize,
            textAlign: TextAlign.center,
            style: AppTextStyles.onbDropCaption,
          ),
          SizedBox(height: AppSizes.onbDropCaptionButtonGap),
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
