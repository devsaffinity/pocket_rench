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
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/professional_profile.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/professional_profile_view_model.dart';
import 'package:pocketwrench/features/shared/profile/data/models/account.dart';
import 'package:pocketwrench/features/shared/profile/views/widgets/edit_profile_avatar.dart';

/// The mechanic's professional profile: basics, brands and expertise.
class ProfessionalProfileView extends GetView<ProfessionalProfileViewModel> {
  const ProfessionalProfileView({super.key});

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
            GetBuilder<ProfessionalProfileViewModel>(
              id: AppUpdateIds.professionalProfile,
              builder: (vm) {
                final profile = vm.profile;
                final account = vm.account;
                if (vm.state == ViewState.error) {
                  return AppEmptyState(
                    title: AppStrings.genericError,
                    actionLabel: AppStrings.retry,
                    onAction: vm.load,
                  );
                }
                if (profile == null || account == null) {
                  return const Center(child: AppLoader());
                }

                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.screenPaddingH,
                    AppSizes.authTitleTopRole + topShift,
                    AppSizes.screenPaddingH,
                    math.max(context.bottomInset, AppSizes.proBottom),
                  ),
                  child: FadeSlideIn(
                    child: _Content(
                      profile: profile,
                      account: account,
                      viewModel: vm,
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
  const _Content({
    required this.profile,
    required this.account,
    required this.viewModel,
  });

  final ProfessionalProfile profile;
  final Account account;
  final ProfessionalProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final sectionGap = SizedBox(height: AppSizes.proSectionGap);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: EditProfileAvatar(
            initials: account.initials,
            onChangePhoto: viewModel.onChangePhoto,
          ),
        ),
        SizedBox(height: AppSizes.proAvatarNameGap),
        Center(child: Text(account.name, style: AppTextStyles.proName)),
        SizedBox(height: AppSizes.proNameRoleGap),
        Center(child: Text(profile.role, style: AppTextStyles.proRole)),
        SizedBox(height: AppSizes.proRoleCityGap),
        Center(child: Text(profile.city, style: AppTextStyles.profileEmail)),
        SizedBox(height: AppSizes.proCityLabelGap),
        _Section(
          label: AppStrings.sectionBasicInfo,
          child: _InfoCard(
            rows: [
              _InfoRow(AppStrings.workshopLabel, profile.workshop),
              _InfoRow(
                AppStrings.experienceLabel,
                AppStrings.yearsOfExperience(profile.yearsExperience),
              ),
            ],
            footer: _Bio(text: profile.bio),
          ),
        ),
        sectionGap,
        _Section(
          label: AppStrings.sectionBrandSpecialization,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppSizes.proBrandCardPadding),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSizes.radiusM),
            ),
            child: Wrap(
              spacing: AppSizes.proChipGap,
              runSpacing: AppSizes.proChipRunGap,
              children: [
                for (final brand in profile.brands)
                  _SkillChip(
                    label: brand,
                    height: AppSizes.proBrandChipHeight,
                    paddingH: AppSizes.proChipPaddingH,
                  ),
              ],
            ),
          ),
        ),
        sectionGap,
        _Section(
          label: AppStrings.sectionExpertise,
          // The design leaves a little more room here than under the others.
          labelGap: AppSizes.proExpertiseLabelGap,
          child: _InfoCard(
            isSubtle: true,
            rows: [
              _InfoRow(AppStrings.tradeLabel, profile.trade),
              _InfoRow(
                AppStrings.primarySpecialtyLabel,
                profile.primarySpecialty,
              ),
              _InfoRow(
                AppStrings.secondarySpecialtyLabel,
                profile.secondarySpecialty,
              ),
            ],
            footer: _Skills(skills: profile.skills),
          ),
        ),
        SizedBox(height: AppSizes.proButtonTop),
        AppButton(
          label: AppStrings.profileEditProfile,
          backgroundColor: AppColors.logoAccent,
          height: AppSizes.buttonHeightTall,
          textStyle: AppTextStyles.requestActionAccent.copyWith(
            fontSize: AppTextStyles.button.fontSize,
          ),
          onPressed: viewModel.onEditProfile,
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.child, this.labelGap});

  final String label;
  final Widget child;

  /// Defaults to [AppSizes.proLabelCardGap].
  final double? labelGap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.profileSection),
        SizedBox(height: labelGap ?? AppSizes.proLabelCardGap),
        child,
      ],
    );
  }
}

class _InfoRow {
  const _InfoRow(this.label, this.value);

  final String label;
  final String value;
}

/// Label and value rows with hairlines between them, then a [footer].
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.rows,
    required this.footer,
    this.isSubtle = false,
  });

  final List<_InfoRow> rows;
  final Widget footer;

  /// The expertise card uses a dimmer label color.
  final bool isSubtle;

  @override
  Widget build(BuildContext context) {
    final labelStyle = isSubtle
        ? AppTextStyles.proLabel.copyWith(color: AppColors.textSubtle)
        : AppTextStyles.proLabel;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.proCardPaddingH,
        vertical: AppSizes.proCardPaddingV,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final row in rows) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.proRowPaddingV),
              child: Row(
                children: [
                  Text(row.label, style: labelStyle),
                  const Spacer(),
                  Text(row.value, style: AppTextStyles.proValue),
                ],
              ),
            ),
            const _Hairline(),
          ],
          Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.proRowPaddingV),
            child: footer,
          ),
        ],
      ),
    );
  }
}

class _Hairline extends StatelessWidget {
  const _Hairline();

  @override
  Widget build(BuildContext context) =>
      Container(height: AppSizes.hairline * 2, color: AppColors.proDivider);
}

class _Bio extends StatelessWidget {
  const _Bio({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.bioLabel, style: AppTextStyles.proLabel),
        SizedBox(height: AppSizes.proBioGap),
        Text(text, style: AppTextStyles.proBio),
      ],
    );
  }
}

class _Skills extends StatelessWidget {
  const _Skills({required this.skills});

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.skillsTitle,
          style: AppTextStyles.proLabel.copyWith(color: AppColors.textSubtle),
        ),
        SizedBox(height: AppSizes.proSkillsGap),
        Wrap(
          spacing: AppSizes.proChipGap,
          runSpacing: AppSizes.proChipRunGap,
          children: [
            for (final skill in skills)
              _SkillChip(
                label: skill,
                height: AppSizes.proSkillChipHeight,
                paddingH: AppSizes.proSkillChipPaddingH,
              ),
          ],
        ),
      ],
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({
    required this.label,
    required this.height,
    required this.paddingH,
  });

  final String label;
  final double height;
  final double paddingH;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.radiusS),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingH),
          // Shrinks to the label's width while centering it vertically.
          child: Center(
            widthFactor: 1,
            child: Text(label, style: AppTextStyles.proChip),
          ),
        ),
      ),
    );
  }
}
