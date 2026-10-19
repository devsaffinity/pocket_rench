import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

enum AppButtonVariant { primary, secondary, outline, text }

/// Design-system button with press animation, haptics and a loading state.
/// Taps are ignored while [isLoading] or [isDisabled].
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.variant = AppButtonVariant.primary,
    this.isFullWidth = true,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.isDisabled = false,
    this.height,
    this.backgroundColor,
    this.textStyle,
    this.borderColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isFullWidth;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final bool isDisabled;

  /// Overrides the variant's default height.
  final double? height;

  /// Overrides the variant's fill color.
  final Color? backgroundColor;

  /// Overrides the variant's label style, including its color.
  final TextStyle? textStyle;

  /// Overrides the outline color of the outline variant.
  final Color? borderColor;

  bool get _isEnabled => !isLoading && !isDisabled && onPressed != null;

  bool get _isPrimary => variant == AppButtonVariant.primary;

  double get _height =>
      height ??
      (_isPrimary ? AppSizes.buttonHeight : AppSizes.buttonHeightSecondary);

  Color get _background => backgroundColor ?? _variantBackground;

  Color get _variantBackground => switch (variant) {
    AppButtonVariant.primary => AppColors.primary,
    AppButtonVariant.secondary => AppColors.surface,
    AppButtonVariant.outline || AppButtonVariant.text => AppColors.transparent,
  };

  Color get _foreground =>
      _isPrimary ? AppColors.onPrimary : AppColors.textPrimary;

  @override
  Widget build(BuildContext context) {
    final style =
        textStyle ??
        (_isPrimary ? AppTextStyles.button : AppTextStyles.buttonSecondary)
            .copyWith(color: _foreground);

    return TapScale(
      onTap: _isEnabled ? onPressed : null,
      haptic: true,
      child: AnimatedOpacity(
        opacity: isDisabled ? AppDurations.disabledOpacity : 1,
        duration: AppDurations.fast,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          width: isFullWidth ? double.infinity : null,
          height: _height,
          padding: EdgeInsets.symmetric(horizontal: AppSizes.spaceL),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _background,
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            border: variant == AppButtonVariant.outline
                ? Border.all(color: borderColor ?? AppColors.border, width: 1.5)
                : null,
          ),
          child: isLoading
              ? AppLoader(color: _foreground)
              : Row(
                  mainAxisSize: isFullWidth
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leading != null) ...[
                      leading!,
                      SizedBox(width: AppSizes.buttonIconGap),
                    ],
                    Flexible(
                      child: Text(
                        label,
                        style: style,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (trailing != null) ...[
                      SizedBox(width: AppSizes.buttonIconGap),
                      trailing!,
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
