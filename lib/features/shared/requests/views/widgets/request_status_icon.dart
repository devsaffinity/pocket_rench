import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';

/// Badge shown on a request: a question mark while it is open, a check once
/// it is resolved.
class RequestStatusIcon extends StatelessWidget {
  const RequestStatusIcon({required this.isResolved, super.key});

  final bool isResolved;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.requestIconBox,
      height: AppSizes.requestIconBox,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.requestIconBackground,
        borderRadius: BorderRadius.circular(AppSizes.requestIconRadius),
      ),
      child: AppImage(
        isResolved ? AppIcons.badgeCheck : AppIcons.badgeHelp,
        width: AppSizes.requestIconSize,
        height: AppSizes.requestIconSize,
        fit: BoxFit.contain,
        color: AppColors.primary,
      ),
    );
  }
}
