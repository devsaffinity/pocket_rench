import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/widgets/app_checkbox.dart';

/// Checkbox followed by a label, vertically centered on each other.
class CheckboxRow extends StatelessWidget {
  const CheckboxRow({
    required this.value,
    required this.onChanged,
    required this.label,
    super.key,
    this.trailing,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget label;

  /// Placed at the far end of the row.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppCheckbox(value: value, onChanged: onChanged),
        SizedBox(width: AppSizes.checkboxGap),
        Expanded(child: label),
        ?trailing,
      ],
    );
  }
}
