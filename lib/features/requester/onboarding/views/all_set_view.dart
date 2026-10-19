import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
import 'package:pocketwrench/features/requester/onboarding/view_models/all_set_view_model.dart';

class AllSetView extends GetView<AllSetViewModel> {
  const AllSetView({super.key});

  @override
  Widget build(BuildContext context) {
    final backTop = math.max(
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
      0,
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
                        iconPath: AppIcons.shieldCheck,
                        diameter: AppSizes.allSetCircle,
                        iconSize: AppSizes.allSetIcon,
                      ),
                      SizedBox(height: AppSizes.allSetCircleTitleGap),
                      AppText.heading(AppStrings.allSetTitle),
                      SizedBox(height: AppSizes.allSetTitleBodyGap),
                      AppText(
                        AppStrings.allSetBody,
                        style: AppTextStyles.bodySmall,
                        align: TextAlign.center,
                      ),
                      SizedBox(height: AppSizes.allSetBodyButtonGap),
                      AppButton(
                        label: AppStrings.allSetGetStarted,
                        onPressed: controller.onGetStarted,
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
