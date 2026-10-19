import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_text_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/shared/auth/view_models/reset_password_view_model.dart';

class ResetPasswordView extends GetView<ResetPasswordViewModel> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.resetTitle,
      subtitle: AppStrings.resetSubtitle,
      bodyTopGap: AppSizes.authHeaderBodyGap,
      body: Column(
        children: [
          GetBuilder<ResetPasswordViewModel>(
            id: AppUpdateIds.resetNewField,
            builder: (vm) => AppTextField.password(
              controller: vm.newPasswordController,
              focusNode: vm.newPasswordFocus,
              label: AppStrings.newPasswordLabel,
              hint: AppStrings.passwordHint,
              errorText: vm.newError,
              obscureText: vm.isNewHidden,
              textInputAction: TextInputAction.next,
              onToggleVisibility: vm.toggleNewVisibility,
              onChanged: vm.onNewChanged,
              onSubmitted: (_) => vm.confirmFocus.requestFocus(),
            ),
          ),
          SizedBox(height: AppSizes.authFieldGap),
          GetBuilder<ResetPasswordViewModel>(
            id: AppUpdateIds.resetConfirmField,
            builder: (vm) => AppTextField.password(
              controller: vm.confirmController,
              focusNode: vm.confirmFocus,
              label: AppStrings.confirmPasswordLabel,
              hint: AppStrings.passwordHint,
              errorText: vm.confirmError,
              obscureText: vm.isConfirmHidden,
              textInputAction: TextInputAction.done,
              onToggleVisibility: vm.toggleConfirmVisibility,
              onChanged: vm.onConfirmChanged,
              onSubmitted: (_) => vm.onSubmit(),
            ),
          ),
        ],
      ),
      bottom: GetBuilder<ResetPasswordViewModel>(
        id: AppUpdateIds.resetSubmit,
        builder: (vm) => AppButton(
          label: AppStrings.resetButton,
          isLoading: vm.isLoading,
          onPressed: vm.onSubmit,
        ),
      ),
    );
  }
}
