import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_text_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/shared/auth/view_models/forgot_password_view_model.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/auth_prompt.dart';

class ForgotPasswordView extends GetView<ForgotPasswordViewModel> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.forgotTitle,
      subtitle: AppStrings.forgotSubtitle,
      bodyTopGap: AppSizes.authHeaderBodyGap,
      bottomPadding: AppSizes.authFooterBottomPadding,
      body: Column(
        children: [
          GetBuilder<ForgotPasswordViewModel>(
            id: AppUpdateIds.forgotEmailField,
            builder: (vm) => AppTextField(
              controller: vm.emailController,
              focusNode: vm.emailFocus,
              label: AppStrings.emailAddressLabel,
              hint: AppStrings.emailHint,
              errorText: vm.emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.email],
              onChanged: vm.onEmailChanged,
              onSubmitted: (_) => vm.onSubmit(),
            ),
          ),
          SizedBox(height: AppSizes.authButtonTopGap),
          GetBuilder<ForgotPasswordViewModel>(
            id: AppUpdateIds.forgotSubmit,
            builder: (vm) => AppButton(
              label: AppStrings.sendResetLink,
              isLoading: vm.isLoading,
              onPressed: vm.onSubmit,
            ),
          ),
        ],
      ),
      bottom: AuthPrompt(
        message: AppStrings.forgotRemember,
        actionLabel: AppStrings.forgotLogIn,
        actionStyle: AppTextStyles.footer,
        onAction: controller.onBackToLogin,
      ),
    );
  }
}
