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
import 'package:pocketwrench/features/mechanic/onboarding/view_models/mechanic_onboarding_view_model.dart';

/// "Verification submitted!" confirmation at the end of onboarding.
class VerificationSubmittedView extends GetView<MechanicOnboardingViewModel> {
  const VerificationSubmittedView({super.key});

  @override
  Widget build(BuildContext context) {
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );
    final bottomGap = math.max(context.bottomInset, AppSizes.authBottomPadding);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIcons,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: AppSizes.authBackLeft,
              top: AppSizes.authBackTop + topShift,
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
                        iconPath: AppIcons.shieldCheck,
                        diameter: AppSizes.allSetCircle,
                        iconSize: AppSizes.onbSubmittedShield,
                      ),
                      SizedBox(height: AppSizes.onbSubmittedCircleTagGap),
                      const _PendingTag(),
                      SizedBox(height: AppSizes.onbSubmittedTagTitleGap),
                      AppText.heading(
                        AppStrings.verificationSubmittedTitle,
                        align: TextAlign.center,
                      ),
                      SizedBox(height: AppSizes.onbSubmittedTitleBodyGap),
                      Text(
                        AppStrings.verificationSubmittedBody,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodySmall,
                      ),
                      SizedBox(height: AppSizes.onbSubmittedBodyCardGap),
                      _InfoCard(
                        certification: controller.submittedCertification,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: AppSizes.screenPaddingH,
              right: AppSizes.screenPaddingH,
              bottom: bottomGap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppButton(
                    label: AppStrings.goToHome,
                    onPressed: controller.onGoHome,
                  ),
                  SizedBox(height: AppSizes.onbSubmittedButtonFootnoteGap),
                  Text(
                    AppStrings.verificationFootnote,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.footnote,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingTag extends StatelessWidget {
  const _PendingTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.onbSubmittedTagHeight,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.onbSubmittedTagPaddingH,
      ),
      decoration: BoxDecoration(
        color: AppColors.pendingTag,
        borderRadius: BorderRadius.circular(AppSizes.onbSubmittedTagHeight / 2),
      ),
      child: Center(
        widthFactor: 1,
        child: Text(
          AppStrings.pendingVerification,
          style: AppTextStyles.pendingTag,
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.certification});

  final String certification;

  Widget _row(String label, String value, TextStyle valueStyle) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.bodySmall)),
        Text(value, style: valueStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.onbSubmittedCardPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Column(
        children: [
          _row(
            AppStrings.averageReviewTime,
            AppStrings.averageReviewTimeValue,
            AppTextStyles.infoValue,
          ),
          SizedBox(height: AppSizes.onbSubmittedCardRowGap),
          _row(
            AppStrings.submittedCertification,
            certification,
            AppTextStyles.infoValueAccent,
          ),
        ],
      ),
    );
  }
}
