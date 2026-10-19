import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';
import 'package:pocketwrench/features/shared/requests/views/widgets/request_status_icon.dart';
import 'package:pocketwrench/features/shared/requests/views/widgets/urgency_tag.dart';

/// A help request: status icon, urgency, title and vehicle summary. Shared by
/// the Requests tab and Home.
class RequestCard extends StatelessWidget {
  const RequestCard({required this.request, required this.onTap, super.key});

  final HelpRequest request;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppSizes.spaceM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RequestStatusIcon(isResolved: request.isResolved),
                const Spacer(),
                UrgencyTag(
                  urgency: request.urgency,
                  height: AppSizes.urgentHeight,
                ),
              ],
            ),
            SizedBox(height: AppSizes.requestCardIconTitleGap),
            Text(request.title, style: AppTextStyles.itemTitle),
            SizedBox(height: AppSizes.requestCardTitleSubGap),
            Text(request.summary, style: AppTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
