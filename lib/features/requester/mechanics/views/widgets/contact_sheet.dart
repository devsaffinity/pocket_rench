import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_radio.dart';
import 'package:pocketwrench/core/widgets/or_divider.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/requester/mechanics/view_models/mechanic_profile_view_model.dart';
import 'package:pocketwrench/features/shared/messages/data/models/support_request.dart';

/// Body of the contact sheet: pick one of your requests, or start a
/// new one.
class ContactSheet extends StatelessWidget {
  const ContactSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MechanicProfileViewModel>(
      id: AppUpdateIds.contactRequests,
      builder: (vm) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.supportRequestLabel,
            style: AppTextStyles.sectionLabel.copyWith(
              color: AppColors.textSubtle,
            ),
          ),
          SizedBox(
            height: AppSizes.sheetLabelGap + AppSizes.contactLabelExtraGap,
          ),
          for (final request in vm.requests) ...[
            _RequestOption(
              request: request,
              isSelected: request.id == vm.selectedRequestId,
              onTap: () => vm.selectRequest(request.id),
            ),
            SizedBox(height: AppSizes.requestCardGap),
          ],
          SizedBox(height: AppSizes.sheetButtonGap - AppSizes.requestCardGap),
          AppButton(
            label: AppStrings.continueToConversation,
            height: AppSizes.buttonHeightSecondary,
            textStyle: AppTextStyles.buttonSmall,
            onPressed: vm.onContinueToConversation,
          ),
          OrDivider(
            verticalPadding: AppSizes.sheetDividerPaddingV,
            bottomPadding: AppSizes.sheetDividerBottom,
            label: AppStrings.orLower,
            labelStyle: AppTextStyles.rowTitle.copyWith(
              color: AppColors.textSubtle,
            ),
          ),
          AppButton(
            label: AppStrings.createSupportRequest,
            variant: AppButtonVariant.secondary,
            textStyle: AppTextStyles.rowTitle.copyWith(
              color: AppColors.primary,
            ),
            onPressed: vm.onCreateSupportRequest,
          ),
        ],
      ),
    );
  }
}

class _RequestOption extends StatelessWidget {
  const _RequestOption({
    required this.request,
    required this.isSelected,
    required this.onTap,
  });

  final SupportRequest request;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.requestCardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.transparent,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(request.title, style: AppTextStyles.rowTitle),
                  SizedBox(height: AppSizes.requestTitleSubtitleGap),
                  Text(request.details, style: AppTextStyles.captionSmall),
                ],
              ),
            ),
            AppRadio(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
