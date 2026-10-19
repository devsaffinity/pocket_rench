import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/profile/view_models/about_view_model.dart';

/// About Us: the app, and links to its legal pages and support.
class AboutView extends GetView<AboutViewModel> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = [
      _AboutRow(
        iconPath: AppIcons.fileText,
        title: AppStrings.aboutTerms,
        onTap: controller.onTerms,
      ),
      _AboutRow(
        iconPath: AppIcons.shield,
        title: AppStrings.aboutPrivacyPolicy,
        onTap: controller.onPrivacyPolicy,
      ),
      _AboutRow(
        iconPath: AppIcons.star,
        title: AppStrings.aboutRate,
        onTap: controller.onRate,
      ),
      _AboutRow(
        iconPath: AppIcons.mail,
        title: AppStrings.aboutContact,
        onTap: controller.onContactSupport,
        isLast: true,
      ),
    ];

    return FlowScaffold(
      title: AppStrings.aboutTitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.settingsGapBelowTitleLoose,
      onBack: controller.onBack,
      body: Column(
        children: [
          Container(
            width: AppSizes.aboutLogoCircle,
            height: AppSizes.aboutLogoCircle,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
            ),
            child: AppImage(
              AppIcons.wrench,
              width: AppSizes.aboutLogoIcon,
              height: AppSizes.aboutLogoIcon,
              fit: BoxFit.contain,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: AppSizes.aboutLogoNameGap),
          AppText.heading(AppStrings.appName, align: TextAlign.center),
          SizedBox(height: AppSizes.aboutNameTaglineGap),
          Text(
            AppStrings.aboutTagline,
            textAlign: TextAlign.center,
            style: AppTextStyles.aboutTagline,
          ),
          SizedBox(height: AppSizes.aboutTaglineCardGap),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.radiusM),
            child: ColoredBox(
              color: AppColors.surface,
              child: Column(children: rows),
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  const _AboutRow({
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.isLast = false,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        height: AppSizes.aboutRowHeight,
        padding: EdgeInsets.only(
          left: AppSizes.aboutRowPadding,
          right: AppSizes.accountRowTrailing,
        ),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : const Border(bottom: BorderSide(color: AppColors.rowDivider)),
        ),
        child: Row(
          children: [
            AppImage(
              iconPath,
              width: AppSizes.aboutRowIcon,
              height: AppSizes.aboutRowIcon,
              fit: BoxFit.contain,
              color: AppColors.textMuted,
            ),
            SizedBox(width: AppSizes.aboutRowIconGap),
            Expanded(child: Text(title, style: AppTextStyles.aboutRow)),
            AppImage(
              AppIcons.chevronRight,
              width: AppSizes.accountChevron,
              height: AppSizes.accountChevron,
              fit: BoxFit.contain,
              color: AppColors.chevron,
            ),
          ],
        ),
      ),
    );
  }
}
