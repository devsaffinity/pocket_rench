import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Label sizes available for [AppChip].
enum AppChipSize { small, compact, regular }

/// Fully rounded label. Selected chips are filled with the accent lime; the
/// rest use the surface color. Pass [onTap] to make it interactive.
class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    required this.height,
    required this.horizontalPadding,
    super.key,
    this.isSelected = false,
    this.onTap,
    this.size = AppChipSize.regular,
    this.selectedColor = AppColors.logoAccent,
    this.labelStyle,
    this.selectedLabelStyle,
  });

  final String label;
  final double height;
  final double horizontalPadding;
  final bool isSelected;
  final VoidCallback? onTap;
  final AppChipSize size;

  /// Fill when selected.
  final Color selectedColor;

  /// Overrides the label style when not selected.
  final TextStyle? labelStyle;

  /// Overrides the label style when selected.
  final TextStyle? selectedLabelStyle;

  TextStyle get _labelStyle =>
      (isSelected ? selectedLabelStyle : labelStyle) ?? _defaultLabelStyle;

  TextStyle get _defaultLabelStyle => switch (size) {
    AppChipSize.small =>
      isSelected ? AppTextStyles.chipLabelXsSelected : AppTextStyles.chip,
    AppChipSize.compact =>
      isSelected
          ? AppTextStyles.chipLabelSmallSelected
          : AppTextStyles.chipLabelSmall,
    AppChipSize.regular =>
      isSelected ? AppTextStyles.chipLabelSelected : AppTextStyles.chipLabel,
  };

  @override
  Widget build(BuildContext context) {
    final chip = SizedBox(
      height: height,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : AppColors.surface,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: AnimatedDefaultTextStyle(
              duration: AppDurations.fast,
              style: _labelStyle,
              child: Text(label),
            ),
          ),
        ),
      ),
    );

    if (onTap == null) return chip;
    return TapScale(onTap: onTap, child: chip);
  }
}
