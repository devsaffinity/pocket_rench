import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';

/// Look of an [AppBottomSheet].
enum AppSheetStyle {
  /// Black sheet with an outline and a close button. The screen behind it is
  /// blurred and dimmed.
  blurred,

  /// Surface-colored panel with no close button. The screen behind it is
  /// dimmed but stays sharp.
  panel,
}

/// Themed bottom sheet. Tapping outside closes it.
abstract final class AppBottomSheet {
  static Future<T?> show<T>({
    required Widget child,
    String? title,
    String? subtitle,
    double? headerTop,
    double? closeTop,
    double? horizontalPadding,
    AppSheetStyle style = AppSheetStyle.blurred,
  }) {
    final isBlurred = style == AppSheetStyle.blurred;

    return Get.generalDialog<T>(
      barrierDismissible: true,
      barrierLabel: AppStrings.close,
      barrierColor: AppColors.transparent,
      transitionDuration: AppDurations.pageTransition,
      pageBuilder: (context, _, _) => Align(
        alignment: Alignment.bottomCenter,
        child: _SheetBody(
          style: style,
          title: title,
          subtitle: subtitle,
          headerTop:
              headerTop ??
              (isBlurred ? AppSizes.sheetHeaderTop : AppSizes.panelTitleTop),
          closeTop: closeTop,
          horizontalPadding:
              horizontalPadding ??
              (isBlurred ? AppSizes.sheetPaddingH : AppSizes.screenPaddingH),
          child: child,
        ),
      ),
      transitionBuilder: (context, animation, _, page) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: AppDurations.standardCurve,
        );
        final scrim = isBlurred
            ? const ColoredBox(color: AppColors.scrim)
            : const ColoredBox(color: AppColors.dimScrim);

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Get.back<void>(),
                child: FadeTransition(
                  opacity: curved,
                  child: isBlurred
                      ? BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: AppSizes.sheetBlur,
                            sigmaY: AppSizes.sheetBlur,
                          ),
                          child: scrim,
                        )
                      : scrim,
                ),
              ),
            ),
            SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(curved),
              child: page,
            ),
          ],
        );
      },
    );
  }
}

class _SheetBody extends StatelessWidget {
  const _SheetBody({
    required this.style,
    required this.child,
    required this.headerTop,
    required this.horizontalPadding,
    this.closeTop,
    this.title,
    this.subtitle,
  });

  final AppSheetStyle style;
  final Widget child;
  final String? title;
  final String? subtitle;
  final double headerTop;
  final double horizontalPadding;
  final double? closeTop;

  bool get _isBlurred => style == AppSheetStyle.blurred;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(
      _isBlurred ? AppSizes.sheetRadius : AppSizes.panelRadius,
    );
    return Material(
      color: AppColors.transparent,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.92,
        ),
        decoration: BoxDecoration(
          color: _isBlurred ? AppColors.background : AppColors.surface,
          borderRadius: BorderRadius.only(topLeft: radius, topRight: radius),
          border: _isBlurred
              ? const Border(
                  top: BorderSide(color: AppColors.border),
                  left: BorderSide(color: AppColors.border),
                  right: BorderSide(color: AppColors.border),
                )
              : null,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            0,
            horizontalPadding,
            math.max(context.bottomInset, AppSizes.sheetBottomPadding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                _Header(
                  title: title!,
                  subtitle: subtitle,
                  top: headerTop,
                  closeTop: closeTop,
                  showClose: _isBlurred,
                  bottomGap: _isBlurred
                      ? AppSizes.sheetHeaderBodyGap
                      : AppSizes.panelTitleRowsGap,
                ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.top,
    required this.showClose,
    required this.bottomGap,
    this.subtitle,
    this.closeTop,
  });

  final String title;
  final String? subtitle;
  final double top;
  final double bottomGap;
  final bool showClose;
  final double? closeTop;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(top: top, bottom: bottomGap),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h1),
                if (subtitle != null) ...[
                  SizedBox(height: AppSizes.sheetTitleSubtitleGap),
                  Text(subtitle!, style: AppTextStyles.sheetSubtitle),
                ],
              ],
            ),
          ),
          if (showClose)
            Positioned(
              top: closeTop ?? top - AppSizes.sheetCloseRise,
              right: -AppSizes.sheetCloseOverhang,
              child: AppIconButton(
                svgPath: AppIcons.close,
                color: AppColors.textPrimary,
                onPressed: () => Get.back<void>(),
              ),
            ),
        ],
      ),
    );
  }
}
