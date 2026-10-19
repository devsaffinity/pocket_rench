import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Labelled field that shows a chosen value (or a hint) and opens a picker when
/// tapped.
class AppSelectField extends StatelessWidget {
  const AppSelectField({
    required this.hint,
    required this.onTap,
    super.key,
    this.label,
    this.value,
    this.errorText,
    this.isCompact = false,
    this.leadingIcon,
    this.trailingIcon = AppIcons.chevronDown,
    this.height,
    this.valueStyle,
    this.hintStyle,
  });

  final String? label;
  final String hint;
  final String? value;
  final String? errorText;
  final VoidCallback onTap;

  /// Slightly taller, with tighter side padding. Used for side-by-side fields.
  final bool isCompact;

  /// Icon before the text (for example a map pin).
  final String? leadingIcon;

  /// Icon after the text. Defaults to a chevron; null shows none.
  final String? trailingIcon;

  /// Overrides the field height.
  final double? height;

  /// Overrides the style of the chosen value.
  final TextStyle? valueStyle;

  /// Overrides the style of the hint.
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTextStyles.label),
          SizedBox(height: AppSizes.authFieldLabelGap),
        ],
        TapScale(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height:
                height ??
                (isCompact
                    ? AppSizes.selectCompactHeight
                    : AppSizes.textFieldHeight),
            padding: EdgeInsets.only(
              left: isCompact
                  ? AppSizes.selectCompactPaddingLeft
                  : AppSizes.spaceM,
              right: leadingIcon != null || trailingIcon != AppIcons.chevronDown
                  ? AppSizes.spaceM
                  : isCompact
                  ? AppSizes.selectCompactChevronInset
                  : AppSizes.selectChevronInset,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
              border: errorText == null
                  ? null
                  : Border.all(color: AppColors.error),
            ),
            child: Row(
              children: [
                if (leadingIcon != null) ...[
                  AppImage(
                    leadingIcon!,
                    width: AppSizes.iconField,
                    height: AppSizes.iconField,
                    fit: BoxFit.contain,
                    color: AppColors.textMuted,
                  ),
                  SizedBox(width: AppSizes.fieldIconGap),
                ],
                Expanded(
                  child: Text(
                    value ?? hint,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: hasValue
                        ? valueStyle ?? AppTextStyles.input
                        : hintStyle ?? AppTextStyles.hint,
                  ),
                ),
                if (trailingIcon != null)
                  AppImage(
                    trailingIcon!,
                    width: AppSizes.iconField,
                    height: AppSizes.iconField,
                    fit: BoxFit.contain,
                    color: AppColors.textSecondary,
                  ),
              ],
            ),
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: AppSizes.spaceXS),
          Text(errorText!, style: AppTextStyles.error),
        ],
      ],
    );
  }
}
