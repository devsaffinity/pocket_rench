import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_onboarding_progress.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_progress_bar.dart';
import 'package:pocketwrench/core/widgets/app_text_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/chip_option.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/onboarding_catalog.dart';
import 'package:pocketwrench/features/mechanic/onboarding/view_models/mechanic_onboarding_view_model.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/widgets/onboarding_widgets.dart';

/// Mechanic onboarding, step 3: certifications, skills and service prices.
class ExpertiseView extends GetView<MechanicOnboardingViewModel> {
  const ExpertiseView({super.key});

  static final List<ChipOption> _skillOptions = [
    for (final skill in OnboardingCatalog.skills) ChipOption(skill),
  ];

  Widget _priceRow(String label, TextEditingController controller) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyles.priceLabel)),
        SizedBox(
          width: AppSizes.onbPriceFieldWidth,
          child: AppTextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textStyle: AppTextStyles.fieldValueBright,
            minHeight: AppSizes.onbPriceFieldHeight,
            contentPaddingV: AppSizes.onbPriceFieldPaddingV,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final sectionGap = SizedBox(height: AppSizes.onbSectionGap);

    return FlowScaffold(
      title: AppStrings.expertiseTitle,
      subtitle: AppStrings.expertiseSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.onbBodyTopGap,
      footerTopGap: AppSizes.onbFooterGap,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppProgressBar(
            fill: AppOnboardingProgress.expertiseFill,
            label: AppStrings.progressPercent(
              AppOnboardingProgress.expertisePercent,
            ),
          ),
          SizedBox(height: AppSizes.onbProgressGap),
          GetBuilder<MechanicOnboardingViewModel>(
            id: AppUpdateIds.onbCertifications,
            builder: (vm) => OnboardingSection(
              label: AppStrings.certificationsLabel,
              child: OnboardingChipGroup(
                options: vm.certificationOptions,
                selected: vm.certifications,
                onToggle: vm.toggleCertification,
                loose: true,
              ),
            ),
          ),
          SizedBox(height: AppSizes.onbHintBottom),
          Text(AppStrings.certificationsHint, style: AppTextStyles.bodySmall),
          SizedBox(height: AppSizes.onbHintBottom),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: controller.customCertificationController,
                  hint: AppStrings.certificationInputHint,
                  textStyle: AppTextStyles.onbSmallInput,
                  minHeight: AppSizes.onbAddFieldHeight,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => controller.onAddCertification(),
                ),
              ),
              SizedBox(width: AppSizes.onbAddRowGap),
              SizedBox(
                width: AppSizes.onbAddButtonWidth,
                child: AppButton(
                  label: AppStrings.addCertification,
                  height: AppSizes.onbAddFieldHeight,
                  onPressed: controller.onAddCertification,
                ),
              ),
            ],
          ),
          sectionGap,
          GetBuilder<MechanicOnboardingViewModel>(
            id: AppUpdateIds.onbSkills,
            builder: (vm) => OnboardingSection(
              label: AppStrings.skillsLabel,
              child: OnboardingChipGroup(
                options: _skillOptions,
                selected: vm.skills,
                onToggle: vm.toggleSkill,
                loose: true,
              ),
            ),
          ),
          sectionGap,
          OnboardingSection(
            label: AppStrings.pricingLabel,
            child: Column(
              children: [
                _priceRow(
                  AppStrings.priceStandard,
                  controller.standardPriceController,
                ),
                SizedBox(height: AppSizes.onbPriceRowGap),
                _priceRow(
                  AppStrings.priceUrgent,
                  controller.urgentPriceController,
                ),
                SizedBox(height: AppSizes.onbPriceRowGap),
                _priceRow(AppStrings.priceLive, controller.livePriceController),
              ],
            ),
          ),
        ],
      ),
      bottom: AppButton(
        label: AppStrings.next,
        height: AppSizes.buttonHeightTall,
        onPressed: controller.onNextFromExpertise,
      ),
    );
  }
}
