import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_text_styles.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/extensions.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_bottom_sheet.dart';
import 'package:pocketwrench/core/widgets/app_button.dart';
import 'package:pocketwrench/core/widgets/app_empty_state.dart';
import 'package:pocketwrench/core/widgets/app_icon_button.dart';
import 'package:pocketwrench/core/widgets/app_image.dart';
import 'package:pocketwrench/core/widgets/app_loader.dart';
import 'package:pocketwrench/core/widgets/fade_slide_in.dart';
import 'package:pocketwrench/core/widgets/tap_scale.dart';
import 'package:pocketwrench/features/shared/profile/data/models/account.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_menu.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_view_model.dart';
import 'package:pocketwrench/features/shared/profile/views/widgets/profile_menu_row.dart';

/// The Profile tab body. Hosted by the main shell.
class ProfileTab extends GetView<ProfileViewModel> {
  const ProfileTab({super.key});

  Future<void> _confirmLogout() {
    return AppBottomSheet.show<void>(
      title: AppStrings.logoutConfirmTitle,
      subtitle: AppStrings.logoutConfirmBody,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppButton(
            label: AppStrings.profileLogout,
            height: AppSizes.buttonHeightTall,
            onPressed: () {
              Get.back<void>();
              unawaited(controller.onLogout());
            },
          ),
          SizedBox(height: AppSizes.spaceS),
          AppButton(
            label: AppStrings.cancel,
            variant: AppButtonVariant.secondary,
            height: AppSizes.buttonHeightTall,
            onPressed: Get.back<void>,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menu = controller.menu;
    final topShift = math.max(
      0.0,
      context.topInset + AppSizes.spaceS - AppSizes.authLogoTop,
    );

    return Stack(
      children: [
        SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.only(
            top: AppSizes.accountTop + topShift,
            left: AppSizes.screenPaddingH,
            right: AppSizes.screenPaddingH,
            bottom: AppSizes.homeBottomPadding,
          ),
          child: FadeSlideIn(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<ProfileViewModel>(
                  id: AppUpdateIds.profileHeader,
                  builder: (vm) => _Header(viewModel: vm),
                ),
                SizedBox(height: AppSizes.accountHeaderSectionGap),
                for (var i = 0; i < menu.length; i++) ...[
                  if (i > 0) SizedBox(height: AppSizes.accountSectionGap),
                  _Section(section: menu[i]),
                ],
                SizedBox(height: AppSizes.accountSectionGap),
                ProfileMenuRow(
                  iconPath: AppIcons.logOut,
                  title: AppStrings.profileLogout,
                  isDestructive: true,
                  onTap: _confirmLogout,
                ),
                SizedBox(height: AppSizes.accountVersionTop),
                Text(
                  AppStrings.profileVersion,
                  style: AppTextStyles.profileSection,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: AppSizes.authBackLeft,
          top: AppSizes.authBackTop + topShift,
          child: AppIconButton(
            svgPath: AppIcons.arrowLeft,
            size: AppSizes.iconBack,
            onPressed: controller.onBack,
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.viewModel});

  final ProfileViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final Account? account = viewModel.account;

    if (viewModel.state == ViewState.error) {
      return AppEmptyState(
        title: AppStrings.genericError,
        actionLabel: AppStrings.retry,
        onAction: viewModel.load,
      );
    }
    if (account == null) {
      return SizedBox(
        height: AppSizes.accountAvatar,
        child: const Center(child: AppLoader()),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppImage(
          account.avatarUrl,
          width: AppSizes.accountAvatar,
          height: AppSizes.accountAvatar,
          borderRadius: BorderRadius.circular(AppSizes.accountAvatar),
        ),
        SizedBox(width: AppSizes.accountAvatarGap),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                account.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.profileName,
              ),
              SizedBox(height: AppSizes.accountNameEmailGap),
              Text(
                account.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.profileEmail,
              ),
              SizedBox(height: AppSizes.accountEmailLinkGap),
              TapScale(
                onTap: viewModel.onEditProfile,
                child: Text(
                  AppStrings.profileEditProfile,
                  style: AppTextStyles.profileEditLink,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// An uppercase label followed by its cards.
class _Section extends StatelessWidget {
  const _Section({required this.section});

  final ProfileMenuSection section;

  @override
  Widget build(BuildContext context) {
    final items = section.items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(section.label, style: AppTextStyles.profileSection),
        SizedBox(height: AppSizes.accountSectionLabelGap),
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) SizedBox(height: AppSizes.accountRowGap),
          ProfileMenuRow(
            iconPath: items[i].iconPath,
            title: items[i].title,
            onTap: items[i].onTap,
            isCompact: items[i].isCompact,
            showsVerifiedBadge: items[i].showsVerifiedBadge,
          ),
        ],
      ],
    );
  }
}
