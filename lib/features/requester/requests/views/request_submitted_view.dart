import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/core/widgets/gradient_circle_icon.dart';
import 'package:pocketwrench/features/requester/requests/view_models/request_submitted_view_model.dart';

/// "Request Submitted!" confirmation.
class RequestSubmittedView extends GetView<RequestSubmittedViewModel> {
  const RequestSubmittedView({super.key});

  @override
  Widget build(BuildContext context) {
    final backTop = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIcons,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: AppSizes.authBackLeft,
              top: AppSizes.authBackTop + backTop,
              child: AppIconButton(
                svgPath: AppIcons.arrowLeft,
                size: AppSizes.iconBack,
                onPressed: controller.onBack,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPaddingH,
                ),
                child: FadeSlideIn(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GradientCircleIcon(
                        iconPath: AppIcons.check,
                        diameter: AppSizes.submittedCircle,
                        iconSize: AppSizes.submittedIcon,
                      ),
                      SizedBox(height: AppSizes.submittedCircleTitleGap),
                      AppText.heading(AppStrings.requestSubmittedTitle),
                      SizedBox(height: AppSizes.submittedTitleBodyGap),
                      AppText.body(
                        AppStrings.requestSubmittedBody,
                        align: TextAlign.center,
                      ),
                      SizedBox(height: AppSizes.submittedBodyButtonGap),
                      AppButton(
                        label: AppStrings.goToHome,
                        height: AppSizes.buttonHeightTall,
                        onPressed: controller.onGoHome,
                      ),
                      SizedBox(height: AppSizes.submittedButtonGap),
                      AppButton(
                        label: AppStrings.findAnExpert,
                        variant: AppButtonVariant.outline,
                        height: AppSizes.buttonHeightTall,
                        borderColor: AppColors.primary,
                        textStyle: AppTextStyles.button.copyWith(
                          color: AppColors.primary,
                        ),
                        onPressed: controller.onFindExpert,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
