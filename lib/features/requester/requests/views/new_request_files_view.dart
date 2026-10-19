import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/attachment_picker.dart';
import 'package:pocketwrench/features/requester/requests/view_models/new_request_view_model.dart';
import 'package:pocketwrench/features/requester/requests/views/widgets/attachment_widgets.dart';

/// New request, step 2: add photos, video and documents.
class NewRequestFilesView extends GetView<NewRequestViewModel> {
  const NewRequestFilesView({super.key});

  Widget _tile(String icon, String label, AttachmentSource source) {
    return Expanded(
      child: AttachmentTile(
        iconPath: icon,
        label: label,
        onTap: () => controller.pickAttachment(source),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gap = AppSizes.attachGridGap;

    return FlowScaffold(
      title: AppStrings.addFilesTitle,
      subtitle: AppStrings.addFilesSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.authBodyGapCards,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _tile(
                AppIcons.camera,
                AppStrings.takePhoto,
                AttachmentSource.camera,
              ),
              SizedBox(width: gap),
              _tile(
                AppIcons.image,
                AppStrings.choosePhotos,
                AttachmentSource.photos,
              ),
            ],
          ),
          SizedBox(height: gap),
          Row(
            children: [
              _tile(
                AppIcons.video,
                AppStrings.chooseVideo,
                AttachmentSource.video,
              ),
              SizedBox(width: gap),
              _tile(
                AppIcons.file,
                AppStrings.chooseDocument,
                AttachmentSource.document,
              ),
            ],
          ),
          GetBuilder<NewRequestViewModel>(
            id: AppUpdateIds.requestAttachments,
            builder: (vm) {
              final files = vm.draft.attachments;
              if (files.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.uploadedLabelTop),
                  Text(AppStrings.uploadedFiles, style: AppTextStyles.label),
                  SizedBox(height: AppSizes.uploadedLabelGap),
                  for (var i = 0; i < files.length; i++) ...[
                    if (i > 0) SizedBox(height: AppSizes.fileRowGap),
                    UploadedFileRow(
                      attachment: files[i],
                      onRemove: () => vm.removeAttachment(files[i].id),
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
      bottom: AppButton(
        label: AppStrings.next,
        height: AppSizes.buttonHeightTall,
        onPressed: controller.onNextFromFiles,
      ),
    );
  }
}
