import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// "Already have an account? Log In" row.
class LoginPrompt extends StatelessWidget {
  const LoginPrompt({required this.onLogIn, super.key});

  final VoidCallback onLogIn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(AppStrings.welcomeHaveAccount, style: AppTextStyles.bodyItalic),
        SizedBox(width: AppSizes.welcomeLinkGap),
        TapScale(
          onTap: onLogIn,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: AppSizes.spaceS),
            child: Text(AppStrings.welcomeLogIn, style: AppTextStyles.link),
          ),
        ),
      ],
    );
  }
}
