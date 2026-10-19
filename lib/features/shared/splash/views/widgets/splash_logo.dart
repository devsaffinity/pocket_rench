import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/logo_mark.dart';

/// Logo mark and wordmark lockup.
class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const LogoMark(),
        SizedBox(width: AppSizes.splashLogoGap),
        AppText.display(AppStrings.splashWordmark),
      ],
    );
  }
}
