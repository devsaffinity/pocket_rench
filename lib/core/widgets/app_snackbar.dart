import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';

enum AppSnackbarType { info, success, error }

/// Themed snackbar shown through GetX.
abstract final class AppSnackbar {
  static void show(
    String message, {
    String? title,
    AppSnackbarType type = AppSnackbarType.info,
  }) {
    final accent = switch (type) {
      AppSnackbarType.info => AppColors.primary,
      AppSnackbarType.success => AppColors.success,
      AppSnackbarType.error => AppColors.error,
    };

    Get.closeCurrentSnackbar();
    Get.snackbar(
      '',
      '',
      titleText: title == null
          ? const SizedBox.shrink()
          : Text(title, style: AppTextStyles.label.copyWith(color: accent)),
      messageText: Text(message, style: AppTextStyles.body),
      backgroundColor: AppColors.surface,
      borderColor: accent,
      borderWidth: 1,
      borderRadius: AppSizes.radiusM,
      margin: EdgeInsets.all(AppSizes.spaceM),
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: AppDurations.pageTransition,
      duration: const Duration(seconds: 3),
    );
  }
}
