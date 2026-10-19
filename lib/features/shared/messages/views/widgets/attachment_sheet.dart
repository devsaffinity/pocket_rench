import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/messages/view_models/chat_view_model.dart';

/// The "Add to message" options.
class AttachmentSheet extends GetView<ChatViewModel> {
  const AttachmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Widget row(AttachmentType type, String icon, String label) =>
        _AttachmentRow(
          iconPath: icon,
          label: label,
          // onTap: () => controller.onAttachmentSelected(type),
          onTap: () {
            Get.back<void>();
          },
        );

    final gap = SizedBox(height: AppSizes.attachRowGap);

    return Column(
      children: [
        row(AttachmentType.camera, AppIcons.camera, AppStrings.attachCamera),
        gap,
        row(AttachmentType.photos, AppIcons.image, AppStrings.attachPhotos),
        gap,
        row(AttachmentType.video, AppIcons.video, AppStrings.attachVideo),
        gap,
        row(
          AttachmentType.document,
          AppIcons.fileText,
          AppStrings.attachDocument,
        ),
      ],
    );
  }
}

class _AttachmentRow extends StatelessWidget {
  const _AttachmentRow({
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: AppSizes.attachRowHeight,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.spaceM),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Row(
          children: [
            AppImage(
              iconPath,
              width: AppSizes.attachIcon,
              height: AppSizes.attachIcon,
              fit: BoxFit.contain,
              color: AppColors.primary,
            ),
            SizedBox(width: AppSizes.attachIconGap),
            Text(label, style: AppTextStyles.attachLabel),
          ],
        ),
      ),
    );
  }
}
