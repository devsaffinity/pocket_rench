import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_chip.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_filters.dart';

/// Quick view of the applied filters. Every chip opens the filters sheet.
class FilterBar extends StatelessWidget {
  const FilterBar({required this.filters, required this.onTap, super.key});

  final MechanicFilters filters;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Widget chip(String label, {required bool isActive}) => Padding(
      padding: EdgeInsets.only(right: AppSizes.filterBarChipGap),
      child: AppChip(
        label: label,
        height: AppSizes.filterBarChipHeight,
        horizontalPadding: AppSizes.filterBarChipPaddingH,
        isSelected: isActive,
        size: AppChipSize.compact,
        onTap: onTap,
      ),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          chip(AppStrings.filterSpecialty, isActive: filters.hasSpecialty),
          chip(AppStrings.filterNearMe, isActive: filters.nearMe),
          chip(AppStrings.filterExperience, isActive: filters.hasExperience),
          chip(AppStrings.filterVerified, isActive: filters.verifiedOnly),
        ],
      ),
    );
  }
}
