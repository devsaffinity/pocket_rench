import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_images.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/logo_mark.dart';

/// Full-bleed hero image with the logo mark overlaid at the top left.
class WelcomeHero extends StatelessWidget {
  const WelcomeHero({super.key});

  @override
  Widget build(BuildContext context) {
    final logoTop = math.max(
      context.topInset + AppSizes.spaceS,
      AppSizes.welcomeLogoTop,
    );

    return SizedBox(
      width: double.infinity,
      height: AppSizes.welcomeHeroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const AppImage(AppImages.welcomeHero),
          const ColoredBox(color: AppColors.heroScrim),
          Positioned(
            top: logoTop,
            left: AppSizes.welcomeLogoLeft,
            child: const LogoMark(),
          ),
        ],
      ),
    );
  }
}
