import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_chip.dart';
import 'package:pocketwrench/core/widgets/app_radio.dart';
import 'package:pocketwrench/core/widgets/app_switch.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/requester/explore/view_models/explore_view_model.dart';
import 'package:pocketwrench/features/requester/explore/views/filter_labels.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_filters.dart';

/// Body of the "Mechanic Filters" sheet. Edits a draft in the ViewModel until
/// "Apply Filters" commits it.
class FiltersSheet extends StatelessWidget {
  const FiltersSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExploreViewModel>(
      id: AppUpdateIds.exploreSheet,
      builder: (vm) {
        final draft = vm.draft;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Label(AppStrings.filtersHelpWith),
            Wrap(
              spacing: AppSizes.sheetChipGap,
              runSpacing: AppSizes.sheetChipGap,
              children: [
                for (final specialty in Specialty.values)
                  _SheetChip(
                    label: specialty.label,
                    isSelected: draft.specialties.contains(specialty),
                    onTap: () => vm.toggleSpecialty(specialty),
                  ),
              ],
            ),
            SizedBox(height: AppSizes.sheetGroupGap),
            _ToggleRow(
              title: AppStrings.nearMeTitle,
              subtitle: AppStrings.nearMeSubtitle,
              value: draft.nearMe,
              onChanged: (value) => vm.setNearMe(value: value),
            ),
            SizedBox(height: AppSizes.sheetGroupGapTight),
            const _Label(AppStrings.experienceLabel, gap: false),
            SizedBox(height: AppSizes.sheetRowGap),
            Wrap(
              spacing: AppSizes.radioItemGap,
              runSpacing: AppSizes.sheetChipGap,
              children: [
                for (final range in ExperienceRange.values)
                  _RadioOption(
                    label: range.label,
                    isSelected: draft.experience == range,
                    onTap: () => vm.setExperience(range),
                  ),
              ],
            ),
            SizedBox(height: AppSizes.sheetGroupGapTight),
            const _Label(AppStrings.priceRangeLabel),
            Wrap(
              spacing: AppSizes.sheetChipGap,
              runSpacing: AppSizes.sheetChipGap,
              children: [
                for (final range in PriceRange.values)
                  _SheetChip(
                    label: range.label,
                    isSelected: draft.price == range,
                    onTap: () => vm.setPrice(range),
                  ),
              ],
            ),
            SizedBox(height: AppSizes.sheetVerifiedGap),
            _ToggleRow(
              title: AppStrings.verifiedOnly,
              value: draft.verifiedOnly,
              onChanged: (value) => vm.setVerifiedOnly(value: value),
            ),
            SizedBox(height: AppSizes.sheetButtonGap),
            AppButton(
              label: AppStrings.applyFilters,
              onPressed: vm.applyFilters,
            ),
          ],
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text, {this.gap = true});

  final String text;

  /// Adds the standard space between the label and what follows.
  final bool gap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: gap ? AppSizes.sheetLabelGap : 0),
      child: Text(text, style: AppTextStyles.sheetLabel),
    );
  }
}

class _SheetChip extends StatelessWidget {
  const _SheetChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppChip(
      label: label,
      height: AppSizes.sheetChipHeight,
      horizontalPadding: AppSizes.sheetChipPaddingH,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.sheetLabel),
              if (subtitle != null) ...[
                SizedBox(height: AppSizes.toggleSubtitleGap),
                Text(subtitle!, style: AppTextStyles.sheetBody),
              ],
            ],
          ),
        ),
        AppSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _RadioOption extends StatelessWidget {
  const _RadioOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppRadio(isSelected: isSelected),
          SizedBox(width: AppSizes.radioLabelGap),
          Text(label, style: AppTextStyles.sheetBody),
        ],
      ),
    );
  }
}
