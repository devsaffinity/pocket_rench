import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/profile/data/models/notification_prefs.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_menu.dart';

enum NotificationKind {
  responses,
  chatMessages,
  liveInvites,
  requestResolved,
  responseHelpful,
}

/// Notification preferences: edits a draft that "Save Changes" commits.
class NotificationSettingsViewModel extends GetxController {
  NotificationSettingsViewModel(this._repository);

  final AccountRepository _repository;

  /// Whose settings these are; the list of switches differs.
  ProfileAudience audience = ProfileAudience.requester;

  NotificationPrefs? _prefs;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is ProfileAudience) audience = arguments;
    unawaited(_load());
  }

  Future<void> _load() async {
    _prefs = await _repository.loadNotificationPrefs();
    update([AppUpdateIds.notificationPrefs]);
  }

  bool isOn(NotificationKind kind) {
    final prefs = _prefs;
    if (prefs == null) return false;
    return switch (kind) {
      NotificationKind.responses => prefs.responses,
      NotificationKind.chatMessages => prefs.chatMessages,
      NotificationKind.liveInvites => prefs.liveInvites,
      NotificationKind.requestResolved => prefs.requestResolved,
      NotificationKind.responseHelpful => prefs.responseHelpful,
    };
  }

  void toggle(NotificationKind kind, bool value) {
    final prefs = _prefs;
    if (prefs == null) return;
    _prefs = switch (kind) {
      NotificationKind.responses => prefs.copyWith(responses: value),
      NotificationKind.chatMessages => prefs.copyWith(chatMessages: value),
      NotificationKind.liveInvites => prefs.copyWith(liveInvites: value),
      NotificationKind.requestResolved => prefs.copyWith(
        requestResolved: value,
      ),
      NotificationKind.responseHelpful => prefs.copyWith(
        responseHelpful: value,
      ),
    };
    update([AppUpdateIds.notificationPrefs]);
  }

  Future<void> onSave() async {
    final prefs = _prefs;
    if (_isSaving || prefs == null) return;

    _isSaving = true;
    update([AppUpdateIds.notificationSubmit]);
    try {
      await _repository.saveNotificationPrefs(prefs);
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    } finally {
      _isSaving = false;
      update([AppUpdateIds.notificationSubmit]);
    }

    // Pop first: Get.back() would close an open snackbar instead of the route.
    Get.back<void>();
    AppSnackbar.show(
      AppStrings.notificationsSaved,
      type: AppSnackbarType.success,
    );
  }

  void onBack() => Get.back<void>();
}
