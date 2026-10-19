import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_chip.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/models/chip_option.dart';

/// A label above its control, with the spacing used on every onboarding step.
class OnboardingSection extends StatelessWidget {
  const OnboardingSection({
    required this.label,
    required this.child,
    super.key,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.onbLabel),
        SizedBox(height: AppSizes.onbLabelControlGap),
        child,
      ],
    );
  }
}

/// Wrapping group of toggle chips. [loose] uses the wider spacing drawn for
/// brands, certifications and skills.
class OnboardingChipGroup extends StatelessWidget {
  const OnboardingChipGroup({
    required this.options,
    required this.selected,
    required this.onToggle,
    super.key,
    this.loose = false,
  });

  final List<ChipOption> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final bool loose;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: loose ? AppSizes.onbChipGapLoose : AppSizes.onbChipGapTight,
      runSpacing: loose
          ? AppSizes.onbChipRunGapLoose
          : AppSizes.onbChipRunGapTight,
      children: [
        for (final option in options)
          AppChip(
            label: option.display,
            height: AppSizes.onbChipHeight,
            horizontalPadding: AppSizes.onbChipPaddingH,
            isSelected: selected.contains(option.label),
            labelStyle: AppTextStyles.choiceChip,
            selectedLabelStyle: AppTextStyles.onbChipSelected,
            onTap: () => onToggle(option.label),
          ),
      ],
    );
  }
}

/// Error line shown under a control.
class OnboardingError extends StatelessWidget {
  const OnboardingError(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(top: AppSizes.spaceXS),
      child: Text(message!, style: AppTextStyles.error),
    );
  }
}
