import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/features/shared/welcome/views/widgets/login_prompt.dart';

/// Headline, description and calls to action, entering one after another.
class WelcomeContent extends StatelessWidget {
  const WelcomeContent({
    required this.onGetStarted,
    required this.onLogIn,
    super.key,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onLogIn;

  Duration _step(int index) => AppDurations.entryStagger * index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSizes.screenPaddingH,
        AppSizes.welcomeContentTop,
        AppSizes.screenPaddingH,
        AppSizes.spaceXL,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeSlideIn(
            delay: _step(1),
            child: AppText.heading(AppStrings.welcomeHeading),
          ),
          SizedBox(height: AppSizes.welcomeHeadingBodyGap),
          FadeSlideIn(
            delay: _step(2),
            child: AppText.body(AppStrings.welcomeBody),
          ),
          SizedBox(height: AppSizes.welcomeBodyButtonGap),
          FadeSlideIn(
            delay: _step(3),
            child: AppButton(
              label: AppStrings.welcomeGetStarted,
              onPressed: onGetStarted,
            ),
          ),
          SizedBox(height: AppSizes.welcomeButtonLinkGap),
          FadeSlideIn(
            delay: _step(4),
            child: Center(child: LoginPrompt(onLogIn: onLogIn)),
          ),
        ],
      ),
    );
  }
}
