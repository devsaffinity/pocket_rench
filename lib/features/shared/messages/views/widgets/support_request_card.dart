import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/messages/data/models/support_request.dart';

/// The request a chat is about, pinned at the top of the thread.
class SupportRequestCard extends StatelessWidget {
  const SupportRequestCard({
    required this.request,
    required this.onView,
    super.key,
    this.onStartLiveStream,
  });

  final SupportRequest request;
  final VoidCallback onView;

  /// Mechanic view only: shows a "Start Live Stream" link beside the label.
  final VoidCallback? onStartLiveStream;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // The live-stream row adds a little height at the top; take it back below.
      padding: EdgeInsets.fromLTRB(
        AppSizes.chatCardPadding,
        AppSizes.chatCardPadding,
        AppSizes.chatCardPadding,
        AppSizes.chatCardPadding -
            (onStartLiveStream == null ? 0 : AppSizes.chatLiveRowExtra),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppStrings.supportRequestCardLabel,
                  style: AppTextStyles.sectionLabel,
                ),
              ),
              if (onStartLiveStream != null)
                TapScale(
                  onTap: onStartLiveStream,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: AppSizes.chatLiveDot,
                        height: AppSizes.chatLiveDot,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.logoAccent,
                        ),
                      ),
                      SizedBox(width: AppSizes.chatLiveDotGap),
                      Text(
                        AppStrings.startLiveStream,
                        style: AppTextStyles.liveStream,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(
            height:
                AppSizes.chatCardLabelGap +
                (onStartLiveStream == null ? 0 : AppSizes.chatLiveRowExtra),
          ),
          Text(request.title, style: AppTextStyles.itemTitle),
          SizedBox(height: AppSizes.chatCardTitleGap),
          Row(
            children: [
              Expanded(
                child: Text(request.details, style: AppTextStyles.captionSmall),
              ),
              TapScale(
                onTap: onView,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.viewRequest,
                      style: AppTextStyles.rowTitle.copyWith(
                        color: AppColors.logoAccent,
                      ),
                    ),
                    SizedBox(width: AppSizes.viewRequestArrowGap),
                    AppImage(
                      AppIcons.arrowRight,
                      width: AppSizes.viewRequestArrow,
                      height: AppSizes.viewRequestArrow,
                      fit: BoxFit.contain,
                      color: AppColors.logoAccent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
