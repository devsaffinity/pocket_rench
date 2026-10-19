import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/shared/profile/view_models/privacy_settings_view_model.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_menu.dart';

/// Privacy: the location-privacy card.
class PrivacySettingsView extends GetView<PrivacySettingsViewModel> {
  const PrivacySettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.privacyTitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.settingsGapBelowTitle,
      bottomPadding: AppSizes.settingsBottomPadding,
      onBack: controller.onBack,
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          AppSizes.privacyCardPadding,
          AppSizes.privacyCardPadding,
          AppSizes.privacyCardPadding,
          controller.audience == ProfileAudience.mechanic
              ? AppSizes.privacyCardPaddingBottomMechanic
              : AppSizes.privacyCardPaddingBottom,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.locationPrivacyTitle,
                    style: AppTextStyles.notifyTitle,
                  ),
                ),
                Container(
                  width: AppSizes.privacyCheckCircle,
                  height: AppSizes.privacyCheckCircle,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background,
                  ),
                  child: AppImage(
                    AppIcons.check,
                    width: AppSizes.privacyCheckIcon,
                    height: AppSizes.privacyCheckIcon,
                    fit: BoxFit.contain,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSizes.privacyTitleBodyGap),
            Text(
              controller.audience == ProfileAudience.mechanic
                  ? AppStrings.mechLocationPrivacyBody
                  : AppStrings.locationPrivacyBody,
              style: AppTextStyles.bodySmall,
            ),
            SizedBox(height: AppSizes.privacyBodyBadgeGap),
            Row(
              children: [
                Container(
                  width: AppSizes.privacyDot,
                  height: AppSizes.privacyDot,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent,
                  ),
                ),
                SizedBox(width: AppSizes.privacyDotGap),
                Text(
                  AppStrings.locationPrivacyBadge,
                  style: AppTextStyles.privacyBadge,
                ),
              ],
            ),
          ],
        ),
      ),
      bottom: GetBuilder<PrivacySettingsViewModel>(
        id: AppUpdateIds.privacySubmit,
        builder: (vm) => AppButton(
          label: AppStrings.saveChanges,
          height: AppSizes.buttonHeightTall,
          isLoading: vm.isSaving,
          onPressed: vm.onSave,
        ),
      ),
    );
  }
}
