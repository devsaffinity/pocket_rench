import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Centered "question? Action" footer where the action is tappable.
class AuthPrompt extends StatelessWidget {
  const AuthPrompt({
    required this.message,
    required this.actionLabel,
    required this.onAction,
    super.key,
    this.actionStyle,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  /// Defaults to `AppTextStyles.footerLink`.
  final TextStyle? actionStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(message, style: AppTextStyles.footer),
          SizedBox(width: AppSizes.promptGap),
          TapScale(
            onTap: onAction,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.spaceS),
              child: Text(
                actionLabel,
                style: actionStyle ?? AppTextStyles.footerLink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
