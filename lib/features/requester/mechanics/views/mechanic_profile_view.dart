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
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_chip.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_profile.dart';
import 'package:pocketwrench/features/requester/mechanics/view_models/mechanic_profile_view_model.dart';
import 'package:pocketwrench/features/requester/mechanics/views/widgets/brand_card.dart';
import 'package:pocketwrench/features/requester/mechanics/views/widgets/contact_sheet.dart';
import 'package:pocketwrench/features/requester/mechanics/views/widgets/pricing_card.dart';
import 'package:pocketwrench/features/requester/mechanics/views/widgets/profile_section.dart';
import 'package:pocketwrench/features/requester/mechanics/views/widgets/stat_card.dart';

/// Full-screen mechanic profile with a "Contact Mechanic" call to action.
class MechanicProfileView extends GetView<MechanicProfileViewModel> {
  const MechanicProfileView({super.key});

  Future<void> _openContactSheet(MechanicProfile profile) {
    return AppBottomSheet.show<void>(
      title: AppStrings.contactTitle(profile.mechanic.name),
      subtitle: AppStrings.contactSubtitle,
      headerTop: AppSizes.sheetHeaderTopCompact,
      closeTop: AppSizes.sheetCloseTopCompact,
      child: const ContactSheet(),
    );
  }

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
            GetBuilder<MechanicProfileViewModel>(
              id: AppUpdateIds.profileBody,
              builder: (vm) {
                final profile = vm.profile;
                if (vm.state == ViewState.error) {
                  return AppEmptyState(
                    title: AppStrings.genericError,
                    actionLabel: AppStrings.retry,
                    onAction: vm.load,
                  );
                }
                if (profile == null) return const Center(child: AppLoader());
                return _ProfileContent(
                  profile: profile,
                  topShift: topShift,
                  onContact: () => _openContactSheet(profile),
                );
              },
            ),
            Positioned(
              left: AppSizes.profileBarInset,
              top: AppSizes.profileBarTop + topShift,
              child: AppIconButton(
                svgPath: AppIcons.arrowLeft,
                size: AppSizes.iconBack,
                onPressed: controller.onBack,
              ),
            ),
            Positioned(
              right: AppSizes.profileKebabInset,
              top: AppSizes.profileBarTop + topShift,
              child: AppIconButton(
                svgPath: AppIcons.moreVertical,
                size: AppSizes.profileKebabIcon,
                onPressed: controller.onMore,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({
    required this.profile,
    required this.topShift,
    required this.onContact,
  });

  final MechanicProfile profile;
  final double topShift;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final mechanic = profile.mechanic;
    final horizontal = AppSizes.screenPaddingH;
    final bottomGap = math.max(
      context.bottomInset,
      AppSizes.profileBottomPadding,
    );

    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: FadeSlideIn(
            child: Column(
              children: [
                SizedBox(height: AppSizes.profileAvatarTop + topShift),
                AppImage(
                  mechanic.avatar,
                  width: AppSizes.profileAvatar,
                  height: AppSizes.profileAvatar,
                  borderRadius: BorderRadius.circular(AppSizes.profileAvatar),
                ),
                SizedBox(height: AppSizes.profileAvatarNameGap),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(mechanic.name, style: AppTextStyles.sectionTitle),
                    if (mechanic.isVerified) ...[
                      SizedBox(width: AppSizes.profileBadgeGap),
                      AppImage(
                        AppIcons.verified,
                        width: AppSizes.profileBadgeSize,
                        height: AppSizes.profileBadgeSize,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: AppSizes.profileNameRoleGap),
                Text(profile.role, style: AppTextStyles.bodySmall),
                SizedBox(height: AppSizes.profileRoleCityGap),
                Text(
                  mechanic.city,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textHint,
                  ),
                ),
                SizedBox(height: AppSizes.profileHeaderSectionGap),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontal),
                  child: _Sections(profile: profile),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    horizontal,
                    AppSizes.profileButtonTopGap,
                    horizontal,
                    bottomGap,
                  ),
                  child: AppButton(
                    label: AppStrings.contactMechanic,
                    height: AppSizes.buttonHeightTall,
                    backgroundColor: AppColors.logoAccent,
                    onPressed: onContact,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Sections extends StatelessWidget {
  const _Sections({required this.profile});

  final MechanicProfile profile;

  @override
  Widget build(BuildContext context) {
    final gap = SizedBox(height: AppSizes.profileSectionGap);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileSection(
          label: AppStrings.sectionSpecialties,
          child: Wrap(
            spacing: AppSizes.profileChipGap,
            runSpacing: AppSizes.sheetChipGap,
            children: [
              for (final specialty in profile.specialties)
                AppChip(
                  label: specialty,
                  height: AppSizes.chipPillHeight,
                  horizontalPadding: AppSizes.profileChipPaddingH,
                  size: AppChipSize.small,
                  isSelected: true,
                ),
            ],
          ),
        ),
        gap,
        ProfileSection(
          label: AppStrings.sectionBrands,
          child: Column(
            children: [
              for (var i = 0; i < profile.brands.length; i++) ...[
                if (i > 0) SizedBox(height: AppSizes.brandCardGap),
                BrandCard(expertise: profile.brands[i]),
              ],
            ],
          ),
        ),
        gap,
        ProfileSection(
          label: AppStrings.sectionAbout,
          child: Text(
            profile.about,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
          ),
        ),
        gap,
        ProfileSection(
          label: AppStrings.sectionPricing,
          child: PricingCard(tiers: profile.pricing),
        ),
        gap,
        ProfileSection(
          label: AppStrings.sectionSkills,
          child: Wrap(
            spacing: AppSizes.profileChipGap,
            runSpacing: AppSizes.sheetChipGap,
            children: [
              for (final skill in profile.skills)
                AppChip(
                  label: skill,
                  height: AppSizes.chipPillHeight,
                  horizontalPadding: AppSizes.profileSkillPaddingH,
                  size: AppChipSize.small,
                ),
            ],
          ),
        ),
        gap,
        ProfileSection(
          label: AppStrings.sectionActivity,
          child: Row(
            children: [
              Expanded(
                child: StatCard(
                  value: profile.requestsHelped,
                  label: AppStrings.requestsHelped,
                ),
              ),
              SizedBox(width: AppSizes.statCardGap),
              Expanded(
                child: StatCard(
                  value: profile.helpfulRatings,
                  label: AppStrings.helpfulRatings,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
