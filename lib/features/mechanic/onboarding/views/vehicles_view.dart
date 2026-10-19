import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_onboarding_progress.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_progress_bar.dart';
import 'package:pocketwrench/core/widgets/app_search_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/features/mechanic/onboarding/view_models/mechanic_onboarding_view_model.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/widgets/onboarding_widgets.dart';

/// Mechanic onboarding, step 2: vehicle brands.
class VehiclesView extends GetView<MechanicOnboardingViewModel> {
  const VehiclesView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.vehiclesTitle,
      subtitle: AppStrings.vehiclesSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.onbBodyTopGap,
      footerTopGap: AppSizes.onbFooterGap,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppProgressBar(
            fill: AppOnboardingProgress.vehiclesFill,
            label: AppStrings.progressPercent(
              AppOnboardingProgress.vehiclesPercent,
            ),
          ),
          SizedBox(height: AppSizes.onbProgressGap),
          OnboardingSection(
            label: AppStrings.brandsLabel,
            child: AppSearchField(
              controller: controller.brandSearchController,
              hint: AppStrings.brandsSearchHint,
              height: AppSizes.onbSelectHeight,
              textStyle: AppTextStyles.onbSearchInput,
              onChanged: controller.onBrandSearchChanged,
            ),
          ),
          SizedBox(height: AppSizes.onbSearchChipsGap),
          GetBuilder<MechanicOnboardingViewModel>(
            id: AppUpdateIds.onbBrands,
            builder: (vm) => OnboardingChipGroup(
              options: vm.visibleBrands,
              selected: vm.brands,
              onToggle: vm.toggleBrand,
              loose: true,
            ),
          ),
        ],
      ),
      bottom: AppButton(
        label: AppStrings.next,
        height: AppSizes.buttonHeightTall,
        onPressed: controller.onNextFromVehicles,
      ),
    );
  }
}
