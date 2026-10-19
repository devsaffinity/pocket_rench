import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';

/// Mechanic summary: avatar, name with verified badge, specialty and skills.
class MechanicCard extends StatelessWidget {
  const MechanicCard({
    required this.mechanic,
    required this.onTap,
    super.key,
    this.isCompact = false,
  });

  final Mechanic mechanic;
  final VoidCallback onTap;

  /// Tighter padding, as used in the explore list.
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(
          isCompact ? AppSizes.mechanicCardPaddingCompact : AppSizes.spaceM,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(
              mechanic.avatar,
              width: AppSizes.homeAvatar,
              height: AppSizes.homeAvatar,
              borderRadius: BorderRadius.circular(AppSizes.homeAvatar),
            ),
            SizedBox(width: AppSizes.homeAvatarGap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.mechanicNameTop),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          mechanic.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.mechanicName,
                        ),
                      ),
                      if (mechanic.isVerified) ...[
                        SizedBox(width: AppSizes.mechanicBadgeGap),
                        AppImage(
                          AppIcons.verified,
                          width: AppSizes.mechanicBadgeSize,
                          height: AppSizes.mechanicBadgeSize,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: AppSizes.mechanicNameSubtitleGap),
                  Text(mechanic.summary, style: AppTextStyles.bodySmall),
                  SizedBox(height: AppSizes.mechanicSubtitleChipsGap),
                  Wrap(
                    spacing: AppSizes.chipGap,
                    runSpacing: AppSizes.chipGap,
                    children: [
                      for (final tag in mechanic.tags) _SkillChip(label: tag),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.chipHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.chipHeight / 2),
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.chipPaddingH),
            child: Text(label, style: AppTextStyles.chip),
          ),
        ),
      ),
    );
  }
}
