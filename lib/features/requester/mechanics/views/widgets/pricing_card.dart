import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_profile.dart';

/// Service tiers with their prices, separated by hairlines.
class PricingCard extends StatelessWidget {
  const PricingCard({required this.tiers, super.key});

  final List<ServiceTier> tiers;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.pricingPadding),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Column(
        children: [
          for (var i = 0; i < tiers.length; i++) ...[
            if (i > 0) ...[
              SizedBox(height: AppSizes.pricingDividerGap),
              Container(height: AppSizes.hairline, color: AppColors.border),
              SizedBox(height: AppSizes.pricingDividerGap),
            ],
            _TierRow(tier: tiers[i]),
          ],
        ],
      ),
    );
  }
}

class _TierRow extends StatelessWidget {
  const _TierRow({required this.tier});

  final ServiceTier tier;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(tier.title, style: AppTextStyles.rowTitle)),
            Text('\$${tier.price}', style: AppTextStyles.price),
          ],
        ),
        SizedBox(height: AppSizes.pricingTitleDescGap),
        Text(tier.description, style: AppTextStyles.bodySmall),
      ],
    );
  }
}
