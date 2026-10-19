import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_hero_tags.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';

/// Pocket Wrench dot-grid mark. Carries a Hero so it flies between screens.
class LogoMark extends StatelessWidget {
  const LogoMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: AppHeroTags.logoMark,
      child: AppImage(
        AppIcons.logoMark,
        width: AppSizes.logoMarkWidth,
        height: AppSizes.logoMarkHeight,
        fit: BoxFit.contain,
      ),
    );
  }
}
