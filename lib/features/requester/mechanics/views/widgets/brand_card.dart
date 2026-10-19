import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_profile.dart';

/// A car brand the mechanic knows well, with an initial in a dark tile.
class BrandCard extends StatelessWidget {
  const BrandCard({required this.expertise, super.key});

  final BrandExpertise expertise;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.brandCardPaddingH,
        vertical: AppSizes.brandCardPaddingV,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.brandTile,
            height: AppSizes.brandTile,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppSizes.brandTileRadius),
            ),
            child: Text(
              expertise.brand.characters.first.toUpperCase(),
              style: AppTextStyles.brandLetter,
            ),
          ),
          SizedBox(width: AppSizes.brandTileGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(expertise.brand, style: AppTextStyles.itemTitle),
                Text(expertise.focus, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
