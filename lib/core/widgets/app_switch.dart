import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';

/// On/off switch with a lime track when on.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    required this.value,
    required this.onChanged,
    super.key,
    this.width,
    this.knobSize,
    this.inset,
    this.activeColor,
    this.inactiveColor,
    this.knobColor,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  /// Size and color overrides; the defaults are the lime filter switch.
  final double? width;
  final double? knobSize;
  final double? inset;
  final Color? activeColor;
  final Color? inactiveColor;

  /// Knob color for both states.
  final Color? knobColor;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.selectionClick();
          onChanged(!value);
        },
        child: AnimatedContainer(
          duration: AppDurations.fast,
          curve: AppDurations.standardCurve,
          width: width ?? AppSizes.switchWidth,
          height: AppSizes.switchHeight,
          padding: EdgeInsets.all(inset ?? AppSizes.switchInset),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
            color: value
                ? activeColor ?? AppColors.logoAccent
                : inactiveColor ?? AppColors.surfaceIcon,
            borderRadius: BorderRadius.circular(AppSizes.switchHeight / 2),
          ),
          child: Container(
            width: knobSize ?? AppSizes.switchKnob,
            height: knobSize ?? AppSizes.switchKnob,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  knobColor ??
                  (value ? AppColors.onLime : AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
