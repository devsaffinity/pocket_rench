import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';

/// One box per digit. A transparent text field laid over the boxes receives
/// the keyboard input; the boxes only display [code].
class OtpBoxes extends StatelessWidget {
  const OtpBoxes({
    required this.code,
    required this.length,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onSubmitted,
    super.key,
  });

  final String code;
  final int length;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onSubmitted;

  // Filled boxes are drawn slightly wider than empty ones in the design.
  static const int _filledFlex = 57;
  static const int _emptyFlex = 53;

  Widget _box(int index) {
    final isFilled = index < code.length;

    return Expanded(
      flex: isFilled ? _filledFlex : _emptyFlex,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        height: AppSizes.otpBoxHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.otpBoxRadius),
          border: Border.all(
            color: isFilled ? AppColors.accent : AppColors.transparent,
          ),
        ),
        child: isFilled
            ? Text(code[index], style: AppTextStyles.otpDigit)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    for (var i = 0; i < length; i++) {
      if (i > 0) children.add(SizedBox(width: AppSizes.otpBoxGap));
      children.add(_box(i));
    }

    return Stack(
      children: [
        Row(children: children),
        Positioned.fill(
          child: Opacity(
            opacity: 0,
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.oneTimeCode],
              enableInteractiveSelection: false,
              showCursor: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(length),
              ],
              onChanged: onChanged,
              onSubmitted: (_) => onSubmitted(),
            ),
          ),
        ),
      ],
    );
  }
}
