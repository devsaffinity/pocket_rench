import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';

/// Centered title and message with an optional icon and action button.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.title,
    super.key,
    this.message,
    this.icon,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? message;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.screenPaddingH),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: AppSizes.iconM * 2, color: AppColors.textHint),
              SizedBox(height: AppSizes.spaceM),
            ],
            AppText.heading(title, align: TextAlign.center),
            if (message != null) ...[
              SizedBox(height: AppSizes.spaceS),
              AppText.body(message!, align: TextAlign.center),
            ],
            if (actionLabel != null) ...[
              SizedBox(height: AppSizes.spaceL),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
