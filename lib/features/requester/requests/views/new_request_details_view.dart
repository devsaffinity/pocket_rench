import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_chip.dart';
import 'package:pocketwrench/core/widgets/app_select_field.dart';
import 'package:pocketwrench/core/widgets/app_text_field.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/option_picker_sheet.dart';
import 'package:pocketwrench/features/requester/requests/data/models/vehicle_catalog.dart';
import 'package:pocketwrench/features/requester/requests/view_models/new_request_view_model.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';

/// New request, step 1: describe the problem and the vehicle.
class NewRequestDetailsView extends GetView<NewRequestViewModel> {
  const NewRequestDetailsView({super.key});

  Future<void> _pick<T>({
    required String title,
    required List<T> options,
    required String Function(T) labelOf,
    required T? selected,
    required ValueChanged<T> onSelected,
  }) {
    return AppBottomSheet.show<void>(
      title: title,
      child: OptionPickerSheet<T>(
        options: options,
        labelOf: labelOf,
        selected: selected,
        onSelected: (option) {
          onSelected(option);
          Get.back<void>();
        },
      ),
    );
  }

  static String _urgencyLabel(RequestUrgency urgency) => switch (urgency) {
    RequestUrgency.low => AppStrings.urgencyLow,
    RequestUrgency.normal => AppStrings.urgencyNormal,
    RequestUrgency.urgent => AppStrings.urgencyUrgent,
  };

  @override
  Widget build(BuildContext context) {
    final gap = SizedBox(height: AppSizes.authFieldGap);

    return FlowScaffold(
      title: AppStrings.enterDetailsTitle,
      subtitle: AppStrings.enterDetailsSubtitle,
      titleTop: AppSizes.authTitleTopRole,
      bodyTopGap: AppSizes.requestDetailsBodyGap,
      footerTopGap: AppSizes.requestDetailsFooterGap,
      onBack: controller.onBack,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<NewRequestViewModel>(
            id: AppUpdateIds.requestTitleField,
            builder: (vm) => AppTextField(
              controller: vm.titleController,
              label: AppStrings.problemTitleLabel,
              hint: AppStrings.problemTitleHint,
              errorText: vm.titleError,
              textInputAction: TextInputAction.next,
              onChanged: vm.onTitleChanged,
            ),
          ),
          gap,
          GetBuilder<NewRequestViewModel>(
            id: AppUpdateIds.requestCategoryField,
            builder: (vm) => AppSelectField(
              label: AppStrings.categoryLabel,
              hint: AppStrings.categoryHint,
              value: vm.draft.category,
              errorText: vm.categoryError,
              onTap: () => _pick<String>(
                title: AppStrings.pickCategoryTitle,
                options: VehicleCatalog.categories,
                labelOf: (c) => c,
                selected: vm.draft.category,
                onSelected: vm.selectCategory,
              ),
            ),
          ),
          gap,
          GetBuilder<NewRequestViewModel>(
            id: AppUpdateIds.requestVehicleField,
            builder: (vm) => _VehicleFields(viewModel: vm, onPick: _pick),
          ),
          gap,
          Text(AppStrings.urgencyLabel, style: AppTextStyles.label),
          SizedBox(height: AppSizes.authFieldLabelGap),
          GetBuilder<NewRequestViewModel>(
            id: AppUpdateIds.requestUrgencyField,
            builder: (vm) => Row(
              children: [
                for (final urgency in RequestUrgency.values) ...[
                  AppChip(
                    label: _urgencyLabel(urgency),
                    height: AppSizes.urgencyChipHeight,
                    horizontalPadding: AppSizes.urgencyChipPaddingH,
                    isSelected: vm.draft.urgency == urgency,
                    selectedColor: AppColors.accent,
                    labelStyle: AppTextStyles.choiceChip,
                    selectedLabelStyle: AppTextStyles.choiceChip,
                    onTap: () => vm.selectUrgency(urgency),
                  ),
                  SizedBox(width: AppSizes.urgencyChipGap),
                ],
              ],
            ),
          ),
          gap,
          AppTextField(
            controller: controller.descriptionController,
            label: AppStrings.descriptionLabel,
            hint: AppStrings.descriptionHint,
            minLines: 4,
            maxLines: 6,
            keyboardType: TextInputType.multiline,
            textStyle: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textMuted,
            ),
            contentPaddingV: AppSizes.textareaPaddingV,
            onChanged: controller.onDescriptionChanged,
          ),
        ],
      ),
      bottom: AppButton(
        label: AppStrings.next,
        height: AppSizes.buttonHeightTall,
        onPressed: controller.onNextFromDetails,
      ),
    );
  }
}

class _VehicleFields extends StatelessWidget {
  const _VehicleFields({required this.viewModel, required this.onPick});

  final NewRequestViewModel viewModel;
  final Future<void> Function<T>({
    required String title,
    required List<T> options,
    required String Function(T) labelOf,
    required T? selected,
    required ValueChanged<T> onSelected,
  })
  onPick;

  @override
  Widget build(BuildContext context) {
    final draft = viewModel.draft;

    return Column(
      children: [
        AppSelectField(
          label: AppStrings.makeLabel,
          hint: AppStrings.makeHint,
          value: draft.make,
          errorText: viewModel.makeError,
          isCompact: true,
          onTap: () => onPick<String>(
            title: AppStrings.pickMakeTitle,
            options: VehicleCatalog.makes,
            labelOf: (m) => m,
            selected: draft.make,
            onSelected: viewModel.selectMake,
          ),
        ),
        SizedBox(height: AppSizes.authFieldGap),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppSelectField(
                label: AppStrings.modelLabel,
                hint: AppStrings.modelHint,
                value: draft.model,
                errorText: viewModel.modelError,
                isCompact: true,
                onTap: () => onPick<VehicleModel>(
                  title: AppStrings.pickModelTitle,
                  options: viewModel.availableModels,
                  labelOf: (m) => m.name,
                  selected: viewModel.availableModels
                      .where((m) => m.name == draft.model)
                      .firstOrNull,
                  onSelected: viewModel.selectModel,
                ),
              ),
            ),
            SizedBox(width: AppSizes.modelYearGap),
            SizedBox(
              width: AppSizes.yearFieldWidth,
              child: AppSelectField(
                label: AppStrings.yearLabel,
                hint: AppStrings.yearHint,
                value: draft.year?.toString(),
                errorText: viewModel.yearError,
                isCompact: true,
                onTap: () => onPick<int>(
                  title: AppStrings.pickYearTitle,
                  options: VehicleCatalog.years,
                  labelOf: (y) => '$y',
                  selected: draft.year,
                  onSelected: viewModel.selectYear,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
