import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_pill_button.dart';

/// "My Requests" title with an "Add" button.
class RequestsHeader extends StatelessWidget {
  const RequestsHeader({required this.onAdd, super.key});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.requestsRowHeight,
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppStrings.myRequests,
              style: AppTextStyles.sectionTitle,
            ),
          ),
          AppPillButton(
            label: AppStrings.add,
            onPressed: onAdd,
            height: AppSizes.requestsRowHeight,
            horizontalPadding: AppSizes.addButtonPaddingH,
            textStyle: AppTextStyles.pill,
            leading: Padding(
              padding: EdgeInsets.only(right: AppSizes.addIconGap),
              child: AppImage(
                AppIcons.plus,
                width: AppSizes.addIconSize,
                height: AppSizes.addIconSize,
                fit: BoxFit.contain,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
