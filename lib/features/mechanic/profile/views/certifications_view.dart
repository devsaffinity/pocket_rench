import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/formatters.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/app_text.dart';
import 'package:pocketwrench/core/widgets/flow_scaffold.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/certification.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/certifications_view_model.dart';

/// Certifications on file, and ways to add or write in another.
class CertificationsView extends GetView<CertificationsViewModel> {
  const CertificationsView({super.key});

  Future<void> _openMenu(Certification certification) {
    return AppBottomSheet.show<void>(
      title: certification.name,
      child: TapScale(
        onTap: () {
          Get.back<void>();
          controller.remove(certification);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.spaceM),
          child: Text(
            AppStrings.removeCertification,
            style: AppTextStyles.input.copyWith(color: AppColors.error),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlowScaffold(
      title: AppStrings.currentCertificationsTitle,
      titleTop: AppSizes.authTitleTopRole,
      titleStyle: AppTextStyles.settingsHeading,
      bodyTopGap: AppSizes.priceTitleGap,
      onBack: controller.onBack,
      body: GetBuilder<CertificationsViewModel>(
        id: AppUpdateIds.certificationsList,
        builder: (vm) {
          if (vm.state == ViewState.error) {
            return AppEmptyState(
              title: AppStrings.genericError,
              actionLabel: AppStrings.retry,
              onAction: vm.load,
            );
          }
          if (vm.state != ViewState.success) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.spaceXL),
              child: const Center(child: AppLoader()),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final certification in vm.certifications) ...[
                _CertificationCard(
                  certification: certification,
                  onMenu: () => _openMenu(certification),
                ),
                SizedBox(height: AppSizes.tierCardGap),
              ],
              SizedBox(height: AppSizes.certSectionGap - AppSizes.tierCardGap),
              AppText(
                AppStrings.addCertificationTitle,
                style: AppTextStyles.certSectionHeading,
              ),
              SizedBox(height: AppSizes.certTitleCardGap),
              Row(
                children: [
                  Expanded(
                    child: _AddTile(
                      iconPath: AppIcons.uploadCloud,
                      iconColor: AppColors.logoAccent,
                      iconBackground: AppColors.uploadTileIcon,
                      title: AppStrings.uploadCertificate,
                      hint: AppStrings.uploadCertificateHint,
                      onTap: vm.onUpload,
                    ),
                  ),
                  SizedBox(width: AppSizes.certTileGap),
                  Expanded(
                    child: _AddTile(
                      iconPath: AppIcons.penLine,
                      iconColor: AppColors.white,
                      iconBackground: AppColors.manualTileIcon,
                      title: AppStrings.enterManually,
                      hint: AppStrings.enterManuallyHint,
                      onTap: vm.onEnterManually,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSizes.certSectionGap),
              AppText(
                AppStrings.writeInTitle,
                style: AppTextStyles.certSectionHeading,
              ),
              SizedBox(height: AppSizes.certTitleCardGap),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSizes.writeInPadding),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppSizes.radiusM),
                ),
                child: Column(
                  children: [
                    _WriteInField(viewModel: vm),
                    SizedBox(height: AppSizes.writeInGap),
                    _SubmitButton(
                      isLoading: vm.isSubmitting,
                      onTap: vm.onSubmitWriteIn,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CertificationCard extends StatelessWidget {
  const _CertificationCard({required this.certification, required this.onMenu});

  final Certification certification;
  final VoidCallback onMenu;

  bool get _isVerified => certification.status == CertificationStatus.verified;

  @override
  Widget build(BuildContext context) {
    final date = Formatters.monthYear(certification.date);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSizes.tierCardPaddingH,
        AppSizes.tierCardPaddingTop,
        AppSizes.certMenuInset,
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
                SizedBox(
                  height: AppSizes.tierNameRowHeight,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          certification.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.tierName,
                        ),
                      ),
                      SizedBox(width: AppSizes.certChipGap),
                      _StatusChip(isVerified: _isVerified),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.tierNameBodyGap),
                Text(
                  _isVerified
                      ? AppStrings.certExpires(date)
                      : AppStrings.certSubmitted(date),
                  style: AppTextStyles.tierBody,
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0, -AppSizes.certMenuLift),
            child: AppIconButton(
              svgPath: AppIcons.ellipsis,
              size: AppSizes.certMenuIcon,
              color: AppColors.textSubtle,
              onPressed: onMenu,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.isVerified});

  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    final color = isVerified
        ? AppColors.verifiedChipText
        : AppColors.pendingChipText;

    return Container(
      height: AppSizes.certChipHeight,
      padding: EdgeInsets.only(
        left: isVerified
            ? AppSizes.certChipPaddingIconLeft
            : AppSizes.certChipPaddingH,
        right: AppSizes.certChipPaddingH,
      ),
      decoration: BoxDecoration(
        color: isVerified
            ? AppColors.verifiedChipBackground
            : AppColors.pendingChipBackground,
        borderRadius: BorderRadius.circular(AppSizes.certChipRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isVerified) ...[
            AppImage(
              AppIcons.check,
              width: AppSizes.certChipIcon,
              height: AppSizes.certChipIcon,
              fit: BoxFit.contain,
              color: color,
            ),
            SizedBox(width: AppSizes.certChipIconGap),
          ],
          Text(
            isVerified ? AppStrings.certVerified : AppStrings.certPending,
            style: AppTextStyles.certChip.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}

class _AddTile extends StatelessWidget {
  const _AddTile({
    required this.iconPath,
    required this.iconColor,
    required this.iconBackground,
    required this.title,
    required this.hint,
    required this.onTap,
  });

  final String iconPath;
  final Color iconColor;
  final Color iconBackground;
  final String title;
  final String hint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: onTap,
      child: Container(
        height: AppSizes.certTileHeight,
        padding: EdgeInsets.symmetric(horizontal: AppSizes.certTilePaddingH),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Column(
          children: [
            SizedBox(height: AppSizes.certTilePaddingTop),
            Container(
              width: AppSizes.certTileIconBox,
              height: AppSizes.certTileIconBox,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(AppSizes.radiusS),
              ),
              child: AppImage(
                iconPath,
                width: AppSizes.certTileIcon,
                height: AppSizes.certTileIcon,
                fit: BoxFit.contain,
                color: iconColor,
              ),
            ),
            SizedBox(height: AppSizes.certTileIconTitleGap),
            Text(title, style: AppTextStyles.certTileTitle),
            SizedBox(height: AppSizes.certTileTitleHintGap),
            Text(
              hint,
              textAlign: TextAlign.center,
              style: AppTextStyles.certTileHint,
            ),
          ],
        ),
      ),
    );
  }
}

class _WriteInField extends StatelessWidget {
  const _WriteInField({required this.viewModel});

  final CertificationsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.writeInInputHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.writeInInputPaddingH,
          ),
          child: Center(
            child: TextField(
              controller: viewModel.writeInController,
              focusNode: viewModel.writeInFocus,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => viewModel.onSubmitWriteIn(),
              style: AppTextStyles.writeInInput,
              cursorColor: AppColors.primary,
              decoration: InputDecoration.collapsed(
                hintText: AppStrings.writeInHint,
                hintStyle: AppTextStyles.writeInHint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({required this.isLoading, required this.onTap});

  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TapScale(
      onTap: isLoading ? null : onTap,
      haptic: true,
      child: Container(
        height: AppSizes.writeInButtonHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.logoAccent,
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        child: Text(
          AppStrings.submitForReview,
          style: AppTextStyles.certSubmit,
        ),
      ),
    );
  }
}
