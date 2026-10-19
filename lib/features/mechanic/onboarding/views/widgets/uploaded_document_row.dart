import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/uploaded_document.dart';

/// A credential document in the "Uploaded" list, with a remove button.
class UploadedDocumentRow extends StatelessWidget {
  const UploadedDocumentRow({
    required this.document,
    required this.onRemove,
    super.key,
  });

  final UploadedDocument document;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.onbDocRowHeight,
      padding: EdgeInsets.only(
        left: AppSizes.onbDocRowPaddingLeft,
        right: AppSizes.onbDocRowPaddingRight,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.onbDocIconBox,
            height: AppSizes.onbDocIconBox,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.radiusS),
            ),
            child: AppImage(
              AppIcons.file,
              width: AppSizes.onbDocIcon,
              height: AppSizes.onbDocIcon,
              fit: BoxFit.contain,
              color: AppColors.white,
            ),
          ),
          SizedBox(width: AppSizes.onbDocIconGap),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  document.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.menuTitle.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(
                  '${document.sizeLabel} • ${document.kindLabel}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSubtle,
                  ),
                ),
              ],
            ),
          ),
          TapScale(
            onTap: onRemove,
            haptic: true,
            child: AppImage(
              AppIcons.closeCircle,
              width: AppSizes.onbDocRemoveIcon,
              height: AppSizes.onbDocRemoveIcon,
              fit: BoxFit.contain,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
