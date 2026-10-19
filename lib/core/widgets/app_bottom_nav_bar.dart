import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';

/// One destination in [AppBottomNavBar].
class AppNavItem {
  const AppNavItem({required this.iconPath, required this.label});

  /// SVG asset path from `AppIcons`.
  final String iconPath;
  final String label;
}

/// Bottom navigation with evenly sized items. The selected item is tinted with
/// the primary color. The bar reserves space for the system gesture area.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    super.key,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: EdgeInsets.fromLTRB(
        AppSizes.navPaddingH,
        AppSizes.navPaddingTop,
        AppSizes.navPaddingH,
        math.max(context.bottomInset, AppSizes.navPaddingBottom),
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++)
            Expanded(
              child: _NavButton(
                item: items[i],
                isSelected: i == currentIndex,
                onTap: () => onChanged(i),
              ),
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final AppNavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isSelected,
      label: item.label,
      child: TapScale(
        onTap: onTap,
        haptic: true,
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(
            end: isSelected ? AppColors.primary : AppColors.textMuted,
          ),
          duration: AppDurations.fast,
          builder: (context, color, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppImage(
                item.iconPath,
                width: AppSizes.navIconBox,
                height: AppSizes.navIconBox,
                fit: BoxFit.contain,
                color: color,
              ),
              SizedBox(height: AppSizes.navIconLabelGap),
              Text(
                item.label,
                maxLines: 1,
                style: AppTextStyles.navLabel.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
