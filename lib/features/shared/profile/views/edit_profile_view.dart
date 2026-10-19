import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/formatters.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_select_field.dart';
import 'package:pocketwrench/core/widgets/app_text_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/option_picker_sheet.dart';
import 'package:pocketwrench/features/shared/profile/view_models/edit_profile_view_model.dart';
import 'package:pocketwrench/features/shared/profile/views/widgets/edit_profile_avatar.dart';

/// Edit Profile.
class EditProfileView extends GetView<EditProfileViewModel> {
  const EditProfileView({super.key});

  static final DateTime _earliestBirthDate = DateTime(1900);

  Future<void> _pickBirthDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: controller.birthDate ?? DateTime(now.year - 30),
      firstDate: _earliestBirthDate,
      lastDate: now,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.primary,
            onPrimary: AppColors.onPrimary,
            surface: AppColors.surface,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) controller.selectBirthDate(picked);
  }

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
    final gap = SizedBox(height: AppSizes.editFieldGap);

    return FlowScaffold(
      title: AppStrings.editProfileTitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.settingsGapBelowTitle,
      bottomPadding: AppSizes.editProfileBottomPadding,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GetBuilder<EditProfileViewModel>(
              id: AppUpdateIds.editProfileAvatar,
              builder: (vm) => EditProfileAvatar(
                initials: vm.account?.initials ?? '',
                onChangePhoto: vm.onChangePhoto,
              ),
            ),
          ),
          gap,
          GetBuilder<EditProfileViewModel>(
            id: AppUpdateIds.editProfileName,
            builder: (vm) => AppTextField(
              label: AppStrings.displayNameLabel,
              controller: vm.nameController,
              errorText: vm.nameError,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              onChanged: vm.onNameChanged,
            ),
          ),
          gap,
          GetBuilder<EditProfileViewModel>(
            id: AppUpdateIds.editProfileBirthDate,
            builder: (vm) => AppSelectField(
              label: AppStrings.birthDateLabel,
              hint: AppStrings.birthDateLabel,
              value: vm.birthDate == null
                  ? null
                  : Formatters.longDate(vm.birthDate!),
              trailingIcon: AppIcons.calendar,
              height: AppSizes.fieldHeightIcon,
              valueStyle: AppTextStyles.fieldValueBright,
              onTap: () => _pickBirthDate(context),
            ),
          ),
          gap,
          GetBuilder<EditProfileViewModel>(
            id: AppUpdateIds.editProfileEmail,
            builder: (vm) => AppTextField(
              label: AppStrings.emailLabel,
              controller: vm.emailController,
              errorText: vm.emailError,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onChanged: vm.onEmailChanged,
            ),
          ),
          gap,
          GetBuilder<EditProfileViewModel>(
            id: AppUpdateIds.editProfilePhone,
            builder: (vm) => AppTextField(
              label: AppStrings.phoneLabel,
              controller: vm.phoneController,
              errorText: vm.phoneError,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              textStyle: AppTextStyles.fieldValueBright,
              onChanged: vm.onPhoneChanged,
              onSubmitted: (_) => vm.onSave(),
            ),
          ),
          gap,
          GetBuilder<EditProfileViewModel>(
            id: AppUpdateIds.editProfileLocation,
            builder: (vm) => AppSelectField(
              label: AppStrings.locationLabel,
              hint: AppStrings.locationHint,
              value: vm.city,
              leadingIcon: AppIcons.mapPin,
              trailingIcon: null,
              height: AppSizes.fieldHeightIcon,
              onTap: _pickCity,
            ),
          ),
        ],
      ),
      bottom: GetBuilder<EditProfileViewModel>(
        id: AppUpdateIds.editProfileSubmit,
        builder: (vm) => AppButton(
          label: AppStrings.saveChanges,
          height: AppSizes.buttonHeightTall,
          isLoading: vm.isSaving,
          onPressed: vm.onSave,
        ),
      ),
    );
  }
}
