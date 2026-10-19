import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/requester/requests/view_models/new_request_view_model.dart';

/// The whole problem description, opened from the review step.
class RequestDescriptionView extends GetView<NewRequestViewModel> {
  const RequestDescriptionView({super.key});

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
                padding: EdgeInsets.fromLTRB(
                  AppSizes.requestDescriptionPaddingH,
                  0,
                  AppSizes.requestDescriptionPaddingH,
                  AppSizes.requestDescriptionLift,
                ),
                child: FadeSlideIn(
                  child: Text(
                    controller.draft.description,
                    style: AppTextStyles.descriptionFull,
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
