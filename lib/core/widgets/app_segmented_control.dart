import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Equal-width segments on a rounded track. The selected segment is a pill
/// that slides to it.
class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
    this.pillColor = AppColors.primary,
    this.selectedLabelStyle,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  /// Fill of the selected pill.
  final Color pillColor;

  /// Style of the selected label; defaults to the dark-on-lime style.
  final TextStyle? selectedLabelStyle;

  @override
  Widget build(BuildContext context) {
    // Alignment runs from -1 (first) to 1 (last) across the segments.
    final step = labels.length > 1 ? 2 / (labels.length - 1) : 0;

    return Container(
      height: AppSizes.segmentHeight,
      padding: EdgeInsets.all(AppSizes.segmentPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: AppDurations.fast,
            curve: AppDurations.standardCurve,
            alignment: Alignment(-1.0 + selectedIndex * step, 0),
            child: FractionallySizedBox(
              widthFactor: 1 / labels.length,
              heightFactor: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: pillColor,
                  borderRadius: BorderRadius.circular(AppSizes.segmentRadius),
                ),
              ),
            ),
          ),
          Row(
            children: [
              for (var i = 0; i < labels.length; i++)
                Expanded(
                  child: TapScale(
                    onTap: () => onChanged(i),
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: AppDurations.fast,
                        style: i == selectedIndex
                            ? selectedLabelStyle ??
                                  AppTextStyles.segmentLabelSelected
                            : AppTextStyles.segmentLabel,
                        child: Text(labels[i]),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
