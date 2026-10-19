import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:pocketwrench/features/shared/profile/data/models/account.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_menu.dart';

/// The Profile tab: who is signed in, and the doors to every settings screen.
class ProfileViewModel extends GetxController {
  ProfileViewModel(
    this._repository,
    this._authRepository, {
    required VoidCallback onBack,
    required VoidCallback onAccountChanged,
  }) : _onBack = onBack,
       _onAccountChanged = onAccountChanged;

  final AccountRepository _repository;
  final AuthRepository _authRepository;
  final VoidCallback _onBack;
  final VoidCallback _onAccountChanged;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  Account? _account;
  Account? get account => _account;

  @override
  void onInit() {
    super.onInit();
    unawaited(load());
  }

  Future<void> load() async {
    _state = ViewState.loading;
    update([AppUpdateIds.profileHeader]);
    try {
      _account = await _repository.loadAccount();
      _state = ViewState.success;
    } catch (_) {
      _state = ViewState.error;
    }
    update([AppUpdateIds.profileHeader]);
  }

  Future<void> onEditProfile() async {
    await Get.toNamed<void>(AppRoutes.editProfile);
    await load();
    _onAccountChanged();
  }

  /// Whose profile this is. Mechanics override it.
  ProfileAudience get audience => ProfileAudience.requester;

  /// The sections of the menu. Mechanics add professional settings.
  List<ProfileMenuSection> get menu => [...accountSections, ...generalSections];

  @protected
  List<ProfileMenuSection> get accountSections => [
    ProfileMenuSection(
      label: AppStrings.profileSectionAccount,
      items: [
        ProfileMenuItem(
          iconPath: AppIcons.user,
          title: AppStrings.profileEditProfile,
          onTap: onEditProfile,
        ),
        ProfileMenuItem(
          iconPath: AppIcons.lock,
          title: AppStrings.profileChangePassword,
          onTap: onChangePassword,
        ),
      ],
    ),
  ];

  /// Notifications, privacy, support and about, shared by both roles.
  @protected
  List<ProfileMenuSection> get generalSections => [
    ProfileMenuSection(
      label: AppStrings.profileSectionNotifications,
      items: [notificationsItem],
    ),
    ...extraSections,
    ProfileMenuSection(
      label: AppStrings.profileSectionPrivacy,
      items: [
        ProfileMenuItem(
          iconPath: AppIcons.shield,
          title: AppStrings.profilePrivacy,
          onTap: onPrivacy,
        ),
      ],
    ),
    ProfileMenuSection(
      label: AppStrings.profileSectionSupport,
      items: [
        ProfileMenuItem(
          iconPath: AppIcons.helpCircle,
          title: AppStrings.profileHelp,
          onTap: onHelp,
        ),
      ],
    ),
    ProfileMenuSection(
      label: AppStrings.profileSectionAbout,
      items: [
        ProfileMenuItem(
          iconPath: AppIcons.info,
          title: AppStrings.profileAbout,
          onTap: onAbout,
        ),
      ],
    ),
  ];

  @protected
  ProfileMenuItem get notificationsItem => ProfileMenuItem(
    iconPath: AppIcons.bell,
    title: AppStrings.profileNotificationPrefs,
    onTap: onNotifications,
  );

  /// Sections between Notifications and Privacy (mechanic certifications).
  @protected
  List<ProfileMenuSection> get extraSections => const [];

  void onChangePassword() => Get.toNamed<void>(AppRoutes.changePassword);
  void onNotifications() =>
      Get.toNamed<void>(AppRoutes.notificationSettings, arguments: audience);
  void onPrivacy() =>
      Get.toNamed<void>(AppRoutes.privacySettings, arguments: audience);
  void onAbout() => Get.toNamed<void>(AppRoutes.about);

  // Help & Support is not designed yet.
  void onHelp() => AppSnackbar.show(AppStrings.featureComingSoon);

  void onBack() => _onBack();

  /// Ends the session and returns to role selection, with Welcome beneath it
  /// so Back works as it does for a new visitor. The view asks for
  /// confirmation first.
  Future<void> onLogout() async {
    try {
      await _authRepository.logout();
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    }
    // Not awaited: the future completes only when Welcome is later popped.
    unawaited(Get.offAllNamed<void>(AppRoutes.welcome));
    unawaited(Get.toNamed<void>(AppRoutes.roleSelection));
  }
}
