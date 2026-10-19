import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';

/// Round radio mark: an outlined ring, or a lime disc with a dark dot when
/// selected. Selection is handled by the parent.
class AppRadio extends StatelessWidget {
  const AppRadio({required this.isSelected, super.key});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDurations.fast,
      width: AppSizes.radioSize,
      height: AppSizes.radioSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.logoAccent : AppColors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.logoAccent : AppColors.textSecondary,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? Container(
              width: AppSizes.radioDot,
              height: AppSizes.radioDot,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onLime,
              ),
            )
          : null,
    );
  }
}
