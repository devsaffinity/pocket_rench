import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';

/// Small black label for how urgent a request is.
class UrgencyTag extends StatelessWidget {
  const UrgencyTag({
    required this.urgency,
    required this.height,
    super.key,
    this.textStyle,
    this.horizontalPadding,
  });

  final RequestUrgency urgency;
  final double height;

  /// Overrides the label style (its color still follows the urgency).
  final TextStyle? textStyle;

  /// Overrides the side padding.
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final isUrgent = urgency == RequestUrgency.urgent;
    final label = switch (urgency) {
      RequestUrgency.urgent => AppStrings.urgent,
      RequestUrgency.normal => AppStrings.tagNormal,
      RequestUrgency.low => AppStrings.tagLow,
    };

    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.urgentRadius),
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? AppSizes.urgentPaddingH,
            ),
            child: Text(
              label,
              style: (textStyle ?? AppTextStyles.urgent).copyWith(
                color: isUrgent ? AppColors.urgent : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
