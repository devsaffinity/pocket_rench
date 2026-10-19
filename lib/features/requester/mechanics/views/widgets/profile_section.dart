import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';

/// Uppercase label followed by its content.
class ProfileSection extends StatelessWidget {
  const ProfileSection({required this.label, required this.child, super.key});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.sectionLabel),
        SizedBox(height: AppSizes.profileLabelGap),
        child,
      ],
    );
  }
}
