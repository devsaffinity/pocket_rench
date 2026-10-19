import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// List of choices shown inside an `AppBottomSheet`. The selected one is
/// highlighted with a check.
class OptionPickerSheet<T> extends StatelessWidget {
  const OptionPickerSheet({
    required this.options,
    required this.labelOf,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<T> options;
  final String Function(T option) labelOf;
  final T? selected;
  final ValueChanged<T> onSelected;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          final isSelected = option == selected;

          return TapScale(
            onTap: () => onSelected(option),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.spaceM),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      labelOf(option),
                      style: AppTextStyles.input.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (isSelected)
                    AppImage(
                      AppIcons.check,
                      width: AppSizes.iconField,
                      height: AppSizes.iconField,
                      fit: BoxFit.contain,
                      color: AppColors.primary,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
