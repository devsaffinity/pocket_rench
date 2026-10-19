import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';

/// Hairline rules with a short label ("OR") in the middle.
class OrDivider extends StatelessWidget {
  const OrDivider({
    required this.verticalPadding,
    super.key,
    this.label = AppStrings.or,
    this.labelStyle,
    this.bottomPadding,
  });

  final double verticalPadding;
  final String label;

  /// Defaults to `AppTextStyles.divider`.
  final TextStyle? labelStyle;

  /// Space under the divider when it differs from [verticalPadding].
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: Container(height: AppSizes.hairline, color: AppColors.border),
    );

    return Padding(
      padding: EdgeInsets.only(
        top: verticalPadding,
        bottom: bottomPadding ?? verticalPadding,
      ),
      child: Row(
        children: [
          line,
          SizedBox(width: AppSizes.dividerTextGap),
          Text(label, style: labelStyle ?? AppTextStyles.divider),
          SizedBox(width: AppSizes.dividerTextGap),
          line,
        ],
      ),
    );
  }
}
