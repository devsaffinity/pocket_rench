import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Rounded checkbox that fills with the checkbox color when selected.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({required this.value, required this.onChanged, super.key});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: AppDurations.fast,
        width: AppSizes.checkboxSize,
        height: AppSizes.checkboxSize,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: value ? AppColors.checkbox : AppColors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radiusCheckbox),
          border: Border.all(
            color: value ? AppColors.checkbox : AppColors.textHint,
            width: 1.5,
          ),
        ),
        child: AnimatedOpacity(
          opacity: value ? 1 : 0,
          duration: AppDurations.fast,
          child: AppImage(
            AppIcons.check,
            width: AppSizes.checkboxIconSize,
            height: AppSizes.checkboxIconSize,
            fit: BoxFit.contain,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
