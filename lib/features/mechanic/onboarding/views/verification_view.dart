import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_onboarding_progress.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_progress_bar.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/mechanic/onboarding/view_models/mechanic_onboarding_view_model.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/widgets/document_drop_zone.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/widgets/onboarding_widgets.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/widgets/uploaded_document_row.dart';

/// Mechanic onboarding, step 4: upload credential documents.
class VerificationView extends GetView<MechanicOnboardingViewModel> {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.verificationTitle,
      subtitle: AppStrings.verificationSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.onbBodyTopGap,
      footerTopGap: AppSizes.onbFooterGap,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppProgressBar(
            fill: AppOnboardingProgress.verificationFill,
            label: AppStrings.progressPercent(
              AppOnboardingProgress.verificationPercent,
            ),
          ),
          SizedBox(height: AppSizes.onbProgressGap),
          OnboardingSection(
            label: AppStrings.uploadDocumentLabel,
            child: DocumentDropZone(onBrowse: controller.onBrowseDocuments),
          ),
          GetBuilder<MechanicOnboardingViewModel>(
            id: AppUpdateIds.onbDocuments,
            builder: (vm) {
              final documents = vm.documents;
              if (documents.isEmpty) return const SizedBox.shrink();

              return Padding(
                padding: EdgeInsets.only(top: AppSizes.onbSectionGap),
                child: OnboardingSection(
                  label: AppStrings.uploadedFilesLabel(documents.length),
                  child: Column(
                    children: [
                      for (var i = 0; i < documents.length; i++) ...[
                        if (i > 0) SizedBox(height: AppSizes.onbPriceRowGap),
                        UploadedDocumentRow(
                          document: documents[i],
                          onRemove: () => vm.removeDocument(documents[i].id),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      bottom: GetBuilder<MechanicOnboardingViewModel>(
        id: AppUpdateIds.onbSubmit,
        builder: (vm) => AppButton(
          label: AppStrings.next,
          height: AppSizes.buttonHeightTall,
          isLoading: vm.isSubmitting,
          onPressed: vm.onSubmit,
        ),
      ),
    );
  }
}
