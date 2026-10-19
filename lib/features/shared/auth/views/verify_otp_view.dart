import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/auth/view_models/verify_otp_view_model.dart';
import 'package:pocketwrench/features/shared/auth/views/widgets/otp_boxes.dart';

class VerifyOtpView extends GetView<VerifyOtpViewModel> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.verifyTitle,
      subtitle: AppStrings.verifySubtitle(controller.phone),
      bodyTopGap: AppSizes.authBodyGapCards,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<VerifyOtpViewModel>(
            id: AppUpdateIds.otpBoxes,
            builder: (vm) => OtpBoxes(
              code: vm.code,
              length: VerifyOtpViewModel.codeLength,
              controller: vm.codeController,
              focusNode: vm.codeFocus,
              onChanged: vm.onCodeChanged,
              onSubmitted: vm.onSubmit,
            ),
          ),
          SizedBox(height: AppSizes.otpHelperTop),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(AppStrings.verifyNoCode, style: AppTextStyles.helper),
              SizedBox(width: AppSizes.otpResendGap),
              TapScale(
                onTap: controller.onResend,
                child: Text(
                  AppStrings.verifyResend,
                  style: AppTextStyles.helperAction.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSizes.otpHelperGap),
          TapScale(
            onTap: controller.onChangeContact,
            child: Text(
              AppStrings.verifyChangeContact,
              style: AppTextStyles.helperAction,
            ),
          ),
        ],
      ),
      bottom: GetBuilder<VerifyOtpViewModel>(
        id: AppUpdateIds.otpSubmit,
        builder: (vm) => AppButton(
          label: AppStrings.verifyButton,
          isLoading: vm.isLoading,
          onPressed: vm.onSubmit,
        ),
      ),
    );
  }
}
