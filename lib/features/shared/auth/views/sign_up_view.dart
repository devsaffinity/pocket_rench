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
import 'package:pocketwrench/features/shared/auth/view_models/sign_up_view_model.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/auth_prompt.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/checkbox_row.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/social_buttons.dart';

class SignUpView extends GetView<SignUpViewModel> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      leading: FlowLeading.logo,
      title: AppStrings.signUpTitle,
      subtitle: AppStrings.signUpSubtitle,
      bodyTopGap: AppSizes.authBodyGapCompact,
      bottomPadding: AppSizes.authFooterBottomPadding,
      body: Column(
        children: [
          GetBuilder<SignUpViewModel>(
            id: AppUpdateIds.signUpNameField,
            builder: (vm) => AppTextField(
              controller: vm.nameController,
              focusNode: vm.nameFocus,
              label: AppStrings.fullNameLabel,
              hint: AppStrings.fullNameHint,
              errorText: vm.nameError,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              onChanged: vm.onNameChanged,
              onSubmitted: (_) => vm.emailFocus.requestFocus(),
            ),
          ),
          SizedBox(height: AppSizes.authFieldGap),
          GetBuilder<SignUpViewModel>(
            id: AppUpdateIds.signUpEmailField,
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
              onSubmitted: (_) => vm.phoneFocus.requestFocus(),
            ),
          ),
          SizedBox(height: AppSizes.authFieldGap),
          GetBuilder<SignUpViewModel>(
            id: AppUpdateIds.signUpPhoneField,
            builder: (vm) => AppTextField(
              controller: vm.phoneController,
              focusNode: vm.phoneFocus,
              label: AppStrings.phoneLabel,
              hint: AppStrings.phoneHint,
              errorText: vm.phoneError,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.telephoneNumber],
              onChanged: vm.onPhoneChanged,
              onSubmitted: (_) => vm.passwordFocus.requestFocus(),
            ),
          ),
          SizedBox(height: AppSizes.authFieldGap),
          GetBuilder<SignUpViewModel>(
            id: AppUpdateIds.signUpPasswordField,
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
          SizedBox(height: AppSizes.authTermsGap),
          GetBuilder<SignUpViewModel>(
            id: AppUpdateIds.signUpAgree,
            builder: (vm) => CheckboxRow(
              value: vm.hasAgreed,
              onChanged: vm.toggleAgreement,
              label: Text(AppStrings.signUpTerms, style: AppTextStyles.terms),
            ),
          ),
          SizedBox(height: AppSizes.authTermsGap),
          GetBuilder<SignUpViewModel>(
            id: AppUpdateIds.signUpSubmit,
            builder: (vm) => AppButton(
              label: AppStrings.signUpButton,
              isLoading: vm.isLoading,
              onPressed: vm.onSubmit,
            ),
          ),
          OrDivider(verticalPadding: AppSizes.dividerPaddingVLoose),
          GetBuilder<SignUpViewModel>(
            id: AppUpdateIds.signUpSocial,
            builder: (vm) => SocialButtons(
              loadingProvider: vm.loadingProvider,
              onPressed: vm.signInWithProvider,
            ),
          ),
        ],
      ),
      bottom: AuthPrompt(
        message: AppStrings.signUpHaveAccount,
        actionLabel: AppStrings.signUpSignIn,
        onAction: controller.onSignIn,
      ),
    );
  }
}
