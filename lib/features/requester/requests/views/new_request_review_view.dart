import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/requester/requests/view_models/new_request_view_model.dart';
import 'package:pocketwrench/features/requester/requests/views/widgets/review_card.dart';

/// New request, step 3: check everything, then send.
class NewRequestReviewView extends GetView<NewRequestViewModel> {
  const NewRequestReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.reviewTitle,
      subtitle: AppStrings.reviewSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.authBodyGapCards,
      onBack: controller.onBack,
      body: ReviewCard(
        draft: controller.draft,
        onEditDetails: controller.onEditDetails,
        onEditFiles: controller.onEditFiles,
        onViewDescription: controller.onViewDescription,
      ),
      bottom: GetBuilder<NewRequestViewModel>(
        id: AppUpdateIds.requestSubmit,
        builder: (vm) => AppButton(
          label: AppStrings.sendRequest,
          height: AppSizes.buttonHeightTall,
          isLoading: vm.isSending,
          onPressed: vm.onSend,
        ),
      ),
    );
  }
}
