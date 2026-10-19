import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/features/mechanic/requests/data/models/service_request.dart';

/// Small uppercase label in the corner of a request: its priority while it is
/// open, "RESOLVED" once finished.
class StatusTag extends StatelessWidget {
  const StatusTag({
    required this.label,
    required this.textColor,
    super.key,
    this.backgroundColor = AppColors.background,
  });

  /// The tag a request wears in lists, from its status and priority.
  factory StatusTag.forRequest(ServiceRequest request, {Key? key}) {
    if (request.status == ServiceStatus.resolved) {
      return StatusTag(
        key: key,
        label: AppStrings.tagResolved,
        textColor: AppColors.verifiedTagText,
        backgroundColor: AppColors.resolvedTagBackground,
      );
    }
    return switch (request.priority) {
      RequestPriority.urgent => StatusTag(
        key: key,
        label: AppStrings.urgent,
        textColor: AppColors.urgent,
      ),
      RequestPriority.important => StatusTag(
        key: key,
        label: AppStrings.tagImportant,
        textColor: AppColors.urgent,
      ),
      RequestPriority.normal => StatusTag(
        key: key,
        label: AppStrings.tagNormal,
        textColor: AppColors.textSecondary,
      ),
    };
  }

  /// The "ACTIVE" tag on an accepted request's detail screen.
  const StatusTag.active({super.key})
    : label = AppStrings.tagActive,
      textColor = AppColors.primary,
      backgroundColor = AppColors.emptyIconBackground;

  final String label;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.urgentHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.urgentRadius),
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.urgentPaddingH),
            child: Text(
              label,
              style: AppTextStyles.urgent.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
