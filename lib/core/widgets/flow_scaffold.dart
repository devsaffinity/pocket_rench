import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/core/widgets/logo_mark.dart';

enum FlowLeading { back, logo }

/// Shared frame for step-by-step screens (auth, onboarding): a leading back button or logo, a title
/// and subtitle, a body, and an optional footer pinned to the bottom. Content
/// scrolls when the keyboard or a small screen leaves too little room.
class FlowScaffold extends StatelessWidget {
  const FlowScaffold({
    required this.title,
    required this.body,
    required this.bodyTopGap,
    super.key,
    this.subtitle,
    this.leading = FlowLeading.back,
    this.onBack,
    this.bottom,
    this.titleTop,
    this.bottomPadding,
    this.footerTopGap,
    this.titleStyle,
  });

  final String title;

  /// Omit for screens that go straight from the title to the body.
  final String? subtitle;
  final Widget body;

  /// Space between the subtitle (or the title, without one) and the body.
  final double bodyTopGap;
  final FlowLeading leading;

  /// Defaults to `Get.back()`.
  final VoidCallback? onBack;

  /// Pinned button or footer.
  final Widget? bottom;

  /// Distance from the screen top to the title. Defaults to
  /// `AppSizes.authTitleTop`.
  final double? titleTop;

  /// Space under [bottom]. Defaults to `AppSizes.authBottomPadding`.
  final double? bottomPadding;

  /// Least space between the body and [bottom]. Defaults to
  /// `AppSizes.authFooterTopGap`.
  final double? footerTopGap;

  /// Defaults to the heading style.
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    final horizontal = AppSizes.screenPaddingH;
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );
    final bottomGap = math.max(
      context.bottomInset,
      bottomPadding ?? AppSizes.authBottomPadding,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIcons,
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: AppHelpers.unfocus,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: (titleTop ?? AppSizes.authTitleTop) + topShift,
                      child: Stack(
                        children: [
                          Positioned(
                            left: leading == FlowLeading.back
                                ? AppSizes.authBackLeft
                                : AppSizes.authLogoLeft,
                            top:
                                topShift +
                                (leading == FlowLeading.back
                                    ? AppSizes.authBackTop
                                    : AppSizes.authLogoTop),
                            child: leading == FlowLeading.back
                                ? AppIconButton(
                                    svgPath: AppIcons.arrowLeft,
                                    size: AppSizes.iconBack,
                                    onPressed: onBack ?? () => Get.back<void>(),
                                  )
                                : const LogoMark(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontal),
                      child: FadeSlideIn(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            titleStyle == null
                                ? AppText.heading(title)
                                : AppText(title, style: titleStyle!),
                            if (subtitle != null) ...[
                              SizedBox(height: AppSizes.authTitleSubtitleGap),
                              AppText.body(subtitle!),
                            ],
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: bodyTopGap),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: horizontal),
                      child: FadeSlideIn(
                        delay: AppDurations.entryStagger,
                        child: body,
                      ),
                    ),
                    const Spacer(),
                    if (bottom != null)
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontal,
                          footerTopGap ?? AppSizes.authFooterTopGap,
                          horizontal,
                          bottomGap,
                        ),
                        child: bottom,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
