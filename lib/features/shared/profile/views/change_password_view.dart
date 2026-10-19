import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_text_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/shared/profile/view_models/change_password_view_model.dart';

/// Update Password.
class ChangePasswordView extends GetView<ChangePasswordViewModel> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.updatePasswordTitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.passwordTopGap,
      bottomPadding: AppSizes.settingsBottomPadding,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<ChangePasswordViewModel>(
            id: AppUpdateIds.passwordCurrentField,
            builder: (vm) => AppTextField.password(
              label: AppStrings.currentPasswordLabel,
              hint: AppStrings.currentPasswordHint,
              controller: vm.currentController,
              obscureText: vm.hideCurrent,
              onToggleVisibility: vm.toggleCurrent,
              errorText: vm.currentError,
              textInputAction: TextInputAction.next,
              onChanged: vm.onCurrentChanged,
              minHeight: AppSizes.fieldHeightIcon,
              toggleColor: AppColors.textSubtle,
            ),
          ),
          SizedBox(height: AppSizes.passwordFieldGap),
          GetBuilder<ChangePasswordViewModel>(
            id: AppUpdateIds.passwordNewField,
            builder: (vm) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField.password(
                  label: AppStrings.newPasswordLabel,
                  hint: AppStrings.newPasswordHint,
                  controller: vm.newController,
                  obscureText: vm.hideNew,
                  onToggleVisibility: vm.toggleNew,
                  errorText: vm.newError,
                  textInputAction: TextInputAction.next,
                  onChanged: vm.onNewChanged,
                  minHeight: AppSizes.fieldHeightIcon,
                  toggleColor: AppColors.textSubtle,
                ),
                SizedBox(height: AppSizes.passwordHintTop),
                Text(
                  AppStrings.passwordRule,
                  style: AppTextStyles.profileSection,
                ),
              ],
            ),
          ),
          SizedBox(height: AppSizes.passwordHintBottom),
          GetBuilder<ChangePasswordViewModel>(
            id: AppUpdateIds.passwordConfirmField,
            builder: (vm) => AppTextField.password(
              label: AppStrings.confirmPasswordLabel,
              hint: AppStrings.confirmNewPasswordHint,
              controller: vm.confirmController,
              obscureText: vm.hideConfirm,
              onToggleVisibility: vm.toggleConfirm,
              errorText: vm.confirmError,
              textInputAction: TextInputAction.done,
              onChanged: vm.onConfirmChanged,
              onSubmitted: (_) => vm.onSave(),
              minHeight: AppSizes.fieldHeightIcon,
              toggleColor: AppColors.textSubtle,
            ),
          ),
        ],
      ),
      bottom: GetBuilder<ChangePasswordViewModel>(
        id: AppUpdateIds.passwordSubmit,
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
