import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/requests/data/models/request_attachment.dart';

/// One of the four "add a file" buttons.
class AttachmentTile extends StatelessWidget {
  const AttachmentTile({
    required this.iconPath,
    required this.label,
    required this.onTap,
    super.key,
  });

  final String iconPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        height: AppSizes.attachTileHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImage(
              iconPath,
              width: AppSizes.attachTileIcon,
              height: AppSizes.attachTileIcon,
              fit: BoxFit.contain,
              color: AppColors.textMuted,
            ),
            SizedBox(height: AppSizes.attachTileIconGap),
            Text(label, style: AppTextStyles.gridLabel),
          ],
        ),
      ),
    );
  }
}

/// Square preview of an attachment: its image, or a file icon.
class AttachmentThumb extends StatelessWidget {
  const AttachmentThumb({
    required this.attachment,
    required this.size,
    super.key,
  });

  final RequestAttachment attachment;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = attachment.previewUrl;
    final radius = BorderRadius.circular(AppSizes.fileThumbRadius);

    if (url != null) {
      return AppImage(url, width: size, height: size, borderRadius: radius);
    }
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: radius,
      ),
      child: AppImage(
        AppIcons.file,
        width: AppSizes.iconM,
        height: AppSizes.iconM,
        fit: BoxFit.contain,
        color: AppColors.textMuted,
      ),
    );
  }
}

/// A file in the "Uploaded Files" list, with a progress bar while uploading.
class UploadedFileRow extends StatelessWidget {
  const UploadedFileRow({
    required this.attachment,
    required this.onRemove,
    super.key,
  });

  final RequestAttachment attachment;
  final VoidCallback onRemove;

  static String _kindLabel(AttachmentKind kind) => switch (kind) {
    AttachmentKind.image => AppStrings.tagImage,
    AttachmentKind.video => AppStrings.tagVideo,
    AttachmentKind.document => AppStrings.tagDocument,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSizes.fileRowPaddingLeft,
        AppSizes.fileRowPaddingV,
        AppSizes.fileRowPaddingRight,
        AppSizes.fileRowPaddingV,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          AttachmentThumb(attachment: attachment, size: AppSizes.fileThumb),
          SizedBox(width: AppSizes.fileThumbGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attachment.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.rowTitle,
                ),
                if (attachment.isUploading) ...[
                  SizedBox(height: AppSizes.fileProgressGap),
                  _ProgressBar(progress: attachment.progress),
                ] else ...[
                  SizedBox(height: AppSizes.fileTagGap),
                  Row(
                    children: [
                      _KindTag(label: _kindLabel(attachment.kind)),
                      SizedBox(width: AppSizes.spaceS),
                      Text(
                        attachment.sizeLabel,
                        style: AppTextStyles.dropCaption,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          SizedBox(width: AppSizes.spaceS),
          TapScale(
            onTap: onRemove,
            haptic: true,
            child: AppImage(
              AppIcons.close,
              width: AppSizes.fileRemoveIcon,
              height: AppSizes.fileRemoveIcon,
              fit: BoxFit.contain,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _KindTag extends StatelessWidget {
  const _KindTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.fileTagHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.fileTagRadius),
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.fileTagPaddingH),
            child: Text(label, style: AppTextStyles.tagLabel),
          ),
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSizes.progressHeight / 2),
      child: SizedBox(
        height: AppSizes.progressHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: AppColors.background),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress.clamp(0, 1),
              child: const ColoredBox(color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }
}
