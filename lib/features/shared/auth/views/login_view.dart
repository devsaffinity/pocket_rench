import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_text_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/or_divider.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/auth/view_models/login_view_model.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/auth_prompt.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/checkbox_row.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/social_buttons.dart';

class LoginView extends GetView<LoginViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      leading: FlowLeading.logo,
      title: AppStrings.loginTitle,
      subtitle: AppStrings.loginSubtitle,
      bodyTopGap: AppSizes.authHeaderBodyGap,
      bottomPadding: AppSizes.authFooterBottomPaddingLow,
      body: Column(
        children: [
          GetBuilder<LoginViewModel>(
            id: AppUpdateIds.loginEmailField,
            builder: (vm) => AppTextField(
              controller: vm.emailController,
              focusNode: vm.emailFocus,
              label: AppStrings.emailLabel,
              hint: AppStrings.emailHint,
              errorText: vm.emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              onChanged: vm.onEmailChanged,
              onSubmitted: (_) => vm.passwordFocus.requestFocus(),
            ),
          ),
          SizedBox(height: AppSizes.authFieldGap),
          GetBuilder<LoginViewModel>(
            id: AppUpdateIds.loginPasswordField,
            builder: (vm) => AppTextField.password(
              controller: vm.passwordController,
              focusNode: vm.passwordFocus,
              label: AppStrings.passwordLabel,
              hint: AppStrings.passwordHint,
              errorText: vm.passwordError,
              obscureText: vm.isPasswordHidden,
              textInputAction: TextInputAction.done,
              onToggleVisibility: vm.togglePasswordVisibility,
              onChanged: vm.onPasswordChanged,
              onSubmitted: (_) => vm.onSubmit(),
            ),
          ),
          SizedBox(height: AppSizes.authRememberTop),
          GetBuilder<LoginViewModel>(
            id: AppUpdateIds.loginRemember,
            builder: (vm) => CheckboxRow(
              value: vm.rememberMe,
              onChanged: vm.toggleRememberMe,
              label: Text(
                AppStrings.rememberMe,
                style: AppTextStyles.checkboxLabel,
              ),
              trailing: TapScale(
                onTap: vm.onForgotPassword,
                child: Text(
                  AppStrings.forgotPasswordLink,
                  style: AppTextStyles.linkSoft,
                ),
              ),
            ),
          ),
          SizedBox(height: AppSizes.authButtonTopGap),
          GetBuilder<LoginViewModel>(
            id: AppUpdateIds.loginSubmit,
            builder: (vm) => AppButton(
              label: AppStrings.loginButton,
              isLoading: vm.isLoading,
              onPressed: vm.onSubmit,
            ),
          ),
          OrDivider(verticalPadding: AppSizes.dividerPaddingV),
          GetBuilder<LoginViewModel>(
            id: AppUpdateIds.loginSocial,
            builder: (vm) => SocialButtons(
              loadingProvider: vm.loadingProvider,
              onPressed: vm.signInWithProvider,
            ),
          ),
        ],
      ),
      bottom: AuthPrompt(
        message: AppStrings.loginNoAccount,
        actionLabel: AppStrings.loginSignUp,
        onAction: controller.onSignUp,
      ),
    );
  }
}
