import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_gradients.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// Call-to-action card with a photo on the right. Pass [fadeImageEdge] when
/// the photo has no left fade of its own.
class PromoBanner extends StatelessWidget {
  const PromoBanner({
    required this.title,
    required this.body,
    required this.buttonLabel,
    required this.imagePath,
    required this.onPressed,
    super.key,
    this.fadeImageEdge = false,
    this.wrapTextBesideImage = false,
  });

  final String title;
  final String body;
  final String buttonLabel;
  final String imagePath;
  final VoidCallback onPressed;

  /// Fades the photo into the card on its left edge. Leave off when the image
  /// already has the fade baked in.
  final bool fadeImageEdge;

  /// Keeps the text to the left of the photo, so a long body wraps instead of
  /// running over it.
  final bool wrapTextBesideImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.bannerHeight,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: AppSizes.bannerImageWidth,
            child: Stack(
              fit: StackFit.expand,
              children: [
                AppImage(imagePath),
                if (fadeImageEdge)
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AppGradients.imageEdgeFade,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSizes.bannerPaddingH,
              AppSizes.bannerPaddingTop,
              wrapTextBesideImage
                  ? AppSizes.bannerImageWidth + AppSizes.bannerPaddingH
                  : AppSizes.bannerPaddingH,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.itemTitle),
                SizedBox(height: AppSizes.bannerTitleBodyGap),
                Text(body, style: AppTextStyles.bannerBody),
                SizedBox(height: AppSizes.bannerBodyButtonGap),
                _BannerButton(label: buttonLabel, onTap: onPressed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerButton extends StatelessWidget {
  const _BannerButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      haptic: true,
      child: SizedBox(
        height: AppSizes.bannerButtonHeight,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.logoAccent,
            borderRadius: BorderRadius.circular(AppSizes.bannerButtonRadius),
          ),
          child: Center(
            widthFactor: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.bannerButtonPaddingH,
              ),
              child: Text(label, style: AppTextStyles.bannerButton),
            ),
          ),
        ),
      ),
    );
  }
}
