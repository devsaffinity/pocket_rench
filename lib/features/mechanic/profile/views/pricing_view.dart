import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/app_switch.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/app_text_field.dart';
import 'package:pocketwrench/core/widgets/dashed_border.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/pricing.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/pricing_view_model.dart';

/// Service pricing: tiers, a way to add one, and the minimum charge.
class PricingView extends GetView<PricingViewModel> {
  const PricingView({super.key});

  Future<void> _openNewTier() {
    controller.prepareNewTier();
    return AppBottomSheet.show<void>(
      title: AppStrings.newTierTitle,
      child: GetBuilder<PricingViewModel>(
        id: AppUpdateIds.pricingTiers,
        builder: (vm) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: AppStrings.tierNameLabel,
              hint: AppStrings.tierNameHint,
              controller: vm.tierNameController,
              errorText: vm.tierNameError,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: AppSizes.spaceM),
            AppTextField(
              label: AppStrings.tierPriceLabel,
              hint: AppStrings.tierPriceHint,
              controller: vm.tierPriceController,
              errorText: vm.tierPriceError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(height: AppSizes.spaceM),
            AppTextField(
              label: AppStrings.tierDescriptionLabel,
              hint: AppStrings.tierDescriptionHint,
              controller: vm.tierDescriptionController,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: AppSizes.spaceL),
            AppButton(
              label: AppStrings.addTier,
              height: AppSizes.buttonHeightTall,
              onPressed: () {
                if (vm.addTier()) Get.back<void>();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openMinimum() {
    controller.prepareMinimum();
    return AppBottomSheet.show<void>(
      title: AppStrings.editMinimumTitle,
      child: GetBuilder<PricingViewModel>(
        id: AppUpdateIds.pricingTiers,
        builder: (vm) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: AppStrings.tierPriceLabel,
              hint: AppStrings.tierPriceHint,
              controller: vm.minimumController,
              errorText: vm.minimumError,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: AppSizes.spaceL),
            AppButton(
              label: AppStrings.saveFee,
              height: AppSizes.buttonHeightTall,
              onPressed: () {
                if (vm.setMinimum()) Get.back<void>();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.pricingTiersTitle,
      titleTop: AppSizes.authTitleTopRole,
      titleStyle: AppTextStyles.settingsHeading,
      bodyTopGap: AppSizes.priceTitleGap,
      bottomPadding: AppSizes.settingsBottomPadding,
      onBack: controller.onBack,
      body: GetBuilder<PricingViewModel>(
        id: AppUpdateIds.pricingTiers,
        builder: (vm) {
          final plan = vm.plan;
          if (vm.state == ViewState.error) {
            return AppEmptyState(
              title: AppStrings.genericError,
              actionLabel: AppStrings.retry,
              onAction: vm.load,
            );
          }
          if (plan == null) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
              child: const Center(child: AppLoader()),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final tier in plan.tiers) ...[
                _TierCard(tier: tier, onToggle: () => vm.toggleTier(tier.id)),
                SizedBox(height: AppSizes.tierCardGap),
              ],
              TapScale(
                onTap: _openNewTier,
                child: DashedBorder(
                  color: AppColors.border,
                  radius: AppSizes.radiusL,
                  child: SizedBox(
                    height: AppSizes.dashedButtonHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppImage(
                          AppIcons.plus,
                          width: AppSizes.dashedIcon,
                          height: AppSizes.dashedIcon,
                          fit: BoxFit.contain,
                          color: AppColors.logoAccent,
                        ),
                        SizedBox(width: AppSizes.dashedIconGap),
                        Text(
                          AppStrings.addCustomTier,
                          style: AppTextStyles.dashedAction,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppSizes.priceMinimumTop),
              AppText(
                AppStrings.minimumChargeTitle,
                style: AppTextStyles.settingsHeading,
              ),
              SizedBox(height: AppSizes.priceTitleGap),
              _MinimumCard(amount: plan.minimumCharge, onEdit: _openMinimum),
            ],
          );
        },
      ),
      bottom: GetBuilder<PricingViewModel>(
        id: AppUpdateIds.pricingSubmit,
        builder: (vm) => AppButton(
          label: AppStrings.saveChanges,
          height: AppSizes.buttonHeightTall,
          isLoading: vm.isSaving,
          onPressed: vm.onSave,
        ),
      ),
    );
  }
}

class _TierCard extends StatelessWidget {
  const _TierCard({required this.tier, required this.onToggle});

  final PricingTier tier;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: tier.isEnabled ? 1 : AppSizes.disabledTierOpacity,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          AppSizes.tierCardPaddingH,
          AppSizes.tierCardPaddingTop,
          AppSizes.tierCardPaddingH,
          AppSizes.tierCardPaddingBottom,
        ),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          tier.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.tierName,
                        ),
                      ),
                      SizedBox(width: AppSizes.tierPriceGap),
                      Text('\$${tier.price}', style: AppTextStyles.tierPrice),
                    ],
                  ),
                  SizedBox(height: AppSizes.tierNameBodyGap),
                  Text(tier.description, style: AppTextStyles.tierBody),
                ],
              ),
            ),
            SizedBox(width: AppSizes.tierTextSwitchGap),
            AppSwitch(value: tier.isEnabled, onChanged: (_) => onToggle()),
          ],
        ),
      ),
    );
  }
}

class _MinimumCard extends StatelessWidget {
  const _MinimumCard({required this.amount, required this.onEdit});

  final int amount;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSizes.tierCardPaddingH,
        AppSizes.minimumCardPaddingTop,
        AppSizes.tierCardPaddingH,
        AppSizes.minimumCardPaddingBottom,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusM),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.minimumServiceFee,
                  style: AppTextStyles.tierName,
                ),
                SizedBox(height: AppSizes.minimumTitleBodyGap),
                Text(AppStrings.minimumFeeBody, style: AppTextStyles.tierBody),
              ],
            ),
          ),
          SizedBox(width: AppSizes.minimumTextPriceGap),
          // The price and pen share one tap target, since the pen alone is small.
          TapScale(
            onTap: onEdit,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.spaceM),
              child: Row(
                children: [
                  Text('\$$amount', style: AppTextStyles.tierPrice),
                  SizedBox(width: AppSizes.minimumPriceEditGap),
                  AppImage(
                    AppIcons.penLine,
                    width: AppSizes.minimumEditIcon,
                    height: AppSizes.minimumEditIcon,
                    fit: BoxFit.contain,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
