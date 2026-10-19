import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_select_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/option_picker_sheet.dart';
import 'package:pocketwrench/features/requester/onboarding/view_models/profile_setup_view_model.dart';
import 'package:pocketwrench/features/requester/onboarding/views/widgets/photo_drop_zone.dart';

class ProfileSetupView extends GetView<ProfileSetupViewModel> {
  const ProfileSetupView({super.key});

  Future<void> _pickCity() {
    return AppBottomSheet.show<void>(
      title: AppStrings.cityPickerTitle,
      child: OptionPickerSheet<String>(
        options: controller.cities,
        labelOf: (city) => city,
        selected: controller.city,
        onSelected: (city) {
          controller.selectCity(city);
          Get.back<void>();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.profileTitle,
      subtitle: AppStrings.profileSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.authHeaderBodyGap,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.profilePhotoLabel, style: AppTextStyles.label),
          SizedBox(height: AppSizes.uploadLabelGap),
          PhotoDropZone(onBrowse: controller.onBrowseFiles),
          SizedBox(height: AppSizes.authFieldGap),
          GetBuilder<ProfileSetupViewModel>(
            id: AppUpdateIds.profileLocation,
            builder: (vm) => AppSelectField(
              label: AppStrings.locationLabel,
              hint: AppStrings.locationHint,
              value: vm.city,
              onTap: _pickCity,
            ),
          ),
        ],
      ),
      bottom: GetBuilder<ProfileSetupViewModel>(
        id: AppUpdateIds.profileSubmit,
        builder: (vm) => AppButton(
          label: AppStrings.next,
          height: AppSizes.buttonHeightTall,
          isLoading: vm.isLoading,
          onPressed: vm.onNext,
        ),
      ),
    );
  }
}
