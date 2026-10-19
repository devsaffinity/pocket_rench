import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/verification.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/verification_status_view_model.dart';

/// "Verified" or "Pending Review", with the documents behind it.
class VerificationStatusView extends GetView<VerificationStatusViewModel> {
  const VerificationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIcons,
      child: Scaffold(
        body: Stack(
          children: [
            GetBuilder<VerificationStatusViewModel>(
              id: AppUpdateIds.verificationStatus,
              builder: (vm) {
                final verification = vm.verification;
                if (vm.state == ViewState.error) {
                  return AppEmptyState(
                    title: AppStrings.genericError,
                    actionLabel: AppStrings.retry,
                    onAction: vm.load,
                  );
                }
                if (verification == null) {
                  return const Center(child: AppLoader());
                }

                return Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizes.verPaddingH,
                    ),
                    child: FadeSlideIn(
                      child: _Content(verification: verification),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: AppSizes.authBackLeft,
              top: AppSizes.authBackTop + topShift,
              child: AppIconButton(
                svgPath: AppIcons.arrowLeft,
                size: AppSizes.iconBack,
                onPressed: controller.onBack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.verification});

  final Verification verification;

  bool get _isVerified => verification.status == VerificationStatus.verified;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: AppSizes.verCircle,
            height: AppSizes.verCircle,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isVerified
                  ? AppColors.verifiedCircle
                  : AppColors.pendingCircle,
            ),
            child: AppImage(
              _isVerified ? AppIcons.check : AppIcons.clock,
              width: _isVerified
                  ? AppSizes.verCheckIcon
                  : AppSizes.verClockIcon,
              height: _isVerified
                  ? AppSizes.verCheckIcon
                  : AppSizes.verClockIcon,
              fit: BoxFit.contain,
              color: _isVerified ? AppColors.success : AppColors.pendingAccent,
            ),
          ),
        ),
        SizedBox(height: AppSizes.verCircleTitleGap),
        Center(
          child: Text(
            _isVerified
                ? AppStrings.verifiedTitle
                : AppStrings.pendingReviewTitle,
            style: AppTextStyles.verTitle,
          ),
        ),
        SizedBox(height: AppSizes.verTitleBodyGap),
        Center(
          child: SizedBox(
            width: AppSizes.verBodyWidth,
            child: Text(
              _isVerified
                  ? AppStrings.verifiedBody
                  : AppStrings.pendingReviewBody,
              textAlign: TextAlign.center,
              style: AppTextStyles.verBody,
            ),
          ),
        ),
        SizedBox(height: AppSizes.verBodyLabelGap),
        Text(
          _isVerified
              ? AppStrings.verificationDocuments
              : AppStrings.documentsSubmitted,
          style: AppTextStyles.profileSection,
        ),
        SizedBox(height: AppSizes.verLabelRowsGap),
        for (var i = 0; i < verification.documents.length; i++) ...[
          if (i > 0) SizedBox(height: AppSizes.verRowGap),
          _DocumentRow(
            name: verification.documents[i],
            showsLabel: _isVerified,
          ),
        ],
      ],
    );
  }
}

class _DocumentRow extends StatelessWidget {
  const _DocumentRow({required this.name, required this.showsLabel});

  final String name;

  /// Verified shows "✓ Verified"; pending shows only the check.
  final bool showsLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSizes.verRowHeight,
      padding: EdgeInsets.symmetric(horizontal: AppSizes.verRowPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          Expanded(child: Text(name, style: AppTextStyles.verRowTitle)),
          Transform.translate(
            // Without a label the check sits a little closer to the edge.
            offset: Offset(showsLabel ? 0 : AppSizes.verCheckNudge, 0),
            child: AppImage(
              AppIcons.checkBold,
              width: AppSizes.verStatusIcon,
              height: AppSizes.verStatusIcon,
              fit: BoxFit.contain,
              color: AppColors.success,
            ),
          ),
          if (showsLabel) ...[
            SizedBox(width: AppSizes.verStatusGap),
            Text(AppStrings.documentVerified, style: AppTextStyles.verStatus),
          ],
        ],
      ),
    );
  }
}
