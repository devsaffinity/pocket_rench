import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/features/shared/auth/data/models/social_provider.dart';

/// Google and GitHub sign-in buttons. The button for [loadingProvider] shows a
/// loader and every button ignores taps while one is loading.
class SocialButtons extends StatelessWidget {
  const SocialButtons({
    required this.onPressed,
    super.key,
    this.loadingProvider,
  });

  final ValueChanged<SocialProvider> onPressed;
  final SocialProvider? loadingProvider;

  Widget _button({
    required SocialProvider provider,
    required String label,
    required String iconPath,
    Color? iconColor,
  }) {
    return AppButton(
      label: label,
      variant: AppButtonVariant.secondary,
      isLoading: loadingProvider == provider,
      onPressed: loadingProvider == null ? () => onPressed(provider) : null,
      leading: AppImage(
        iconPath,
        width: AppSizes.iconField,
        height: AppSizes.iconField,
        fit: BoxFit.contain,
        color: iconColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _button(
          provider: SocialProvider.google,
          label: AppStrings.google,
          iconPath: AppIcons.google,
        ),
        SizedBox(height: AppSizes.socialButtonGap),
        _button(
          provider: SocialProvider.github,
          label: AppStrings.github,
          iconPath: AppIcons.github,
          iconColor: AppColors.white,
        ),
      ],
    );
  }
}
