import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_onboarding_progress.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_progress_bar.dart';
import 'package:pocketwrench/core/widgets/app_select_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/option_picker_sheet.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/chip_option.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/onboarding_catalog.dart';
import 'package:pocketwrench/features/mechanic/onboarding/view_models/mechanic_onboarding_view_model.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/widgets/onboarding_widgets.dart';

/// Mechanic onboarding, step 1: trade, years, city and specialties.
class ExperienceView extends GetView<MechanicOnboardingViewModel> {
  const ExperienceView({super.key});

  static final List<ChipOption> _yearOptions = [
    for (final range in OnboardingCatalog.yearsRanges) ChipOption(range),
  ];
  static final List<ChipOption> _specialtyOptions = [
    for (final specialty in OnboardingCatalog.specialties)
      ChipOption(specialty),
  ];

  Future<void> _pickFrom(
    String title,
    List<String> options,
    String? selected,
    ValueChanged<String> onSelected,
  ) {
    return AppBottomSheet.show<void>(
      title: title,
      child: OptionPickerSheet<String>(
        options: options,
        labelOf: (option) => option,
        selected: selected,
        onSelected: (option) {
          onSelected(option);
          Get.back<void>();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sectionGap = SizedBox(height: AppSizes.onbSectionGap);

    return FlowScaffold(
      title: AppStrings.experienceTitle,
      subtitle: AppStrings.experienceSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.onbBodyTopGap,
      footerTopGap: AppSizes.onbFooterGap,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppProgressBar(
            fill: AppOnboardingProgress.experienceFill,
            label: AppStrings.progressPercent(
              AppOnboardingProgress.experiencePercent,
            ),
          ),
          SizedBox(height: AppSizes.onbProgressGap),
          GetBuilder<MechanicOnboardingViewModel>(
            id: AppUpdateIds.onbTrade,
            builder: (vm) => OnboardingSection(
              label: AppStrings.primaryTradeLabel,
              child: AppSelectField(
                hint: AppStrings.primaryTradeHint,
                value: vm.trade,
                errorText: vm.tradeError,
                height: AppSizes.onbSelectHeight,
                valueStyle: AppTextStyles.onbInput,
                hintStyle: AppTextStyles.onbInput.copyWith(
                  color: AppTextStyles.hint.color,
                ),
                onTap: () => _pickFrom(
                  AppStrings.tradePickerTitle,
                  OnboardingCatalog.trades,
                  vm.trade,
                  vm.selectTrade,
                ),
              ),
            ),
          ),
          sectionGap,
          GetBuilder<MechanicOnboardingViewModel>(
            id: AppUpdateIds.onbYears,
            builder: (vm) => OnboardingSection(
              label: AppStrings.yearsLabel,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OnboardingChipGroup(
                    options: _yearOptions,
                    selected: {?vm.years},
                    onToggle: vm.selectYears,
                  ),
                  OnboardingError(vm.yearsError),
                ],
              ),
            ),
          ),
          sectionGap,
          GetBuilder<MechanicOnboardingViewModel>(
            id: AppUpdateIds.onbCity,
            builder: (vm) => OnboardingSection(
              label: AppStrings.cityLabel,
              child: AppSelectField(
                hint: AppStrings.locationHint,
                value: vm.city,
                errorText: vm.cityError,
                height: AppSizes.onbSelectHeight,
                valueStyle: AppTextStyles.onbInput,
                hintStyle: AppTextStyles.onbInput.copyWith(
                  color: AppTextStyles.hint.color,
                ),
                onTap: () => _pickFrom(
                  AppStrings.cityPickerTitle,
                  vm.cities,
                  vm.city,
                  vm.selectCity,
                ),
              ),
            ),
          ),
          sectionGap,
          GetBuilder<MechanicOnboardingViewModel>(
            id: AppUpdateIds.onbSpecialties,
            builder: (vm) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.specialtiesLabel,
                  style: AppTextStyles.onbLabel,
                ),
                SizedBox(height: AppSizes.onbHintTop),
                Text(
                  AppStrings.specialtiesHint,
                  style: AppTextStyles.bodySmall,
                ),
                SizedBox(height: AppSizes.onbHintBottom),
                OnboardingChipGroup(
                  options: _specialtyOptions,
                  selected: vm.specialties,
                  onToggle: vm.toggleSpecialty,
                ),
                OnboardingError(vm.specialtiesError),
              ],
            ),
          ),
        ],
      ),
      bottom: AppButton(
        label: AppStrings.next,
        height: AppSizes.buttonHeightTall,
        onPressed: controller.onNextFromExperience,
      ),
    );
  }
}
