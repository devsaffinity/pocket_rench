import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/profile/data/models/privacy_settings.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_menu.dart';

/// Privacy. The design offers one fixed choice (city-level location only), so
/// there is nothing to edit yet; "Save Changes" stores it and goes back.
class PrivacySettingsViewModel extends GetxController {
  PrivacySettingsViewModel(this._repository);

  final AccountRepository _repository;

  /// Whose settings these are; the wording differs.
  ProfileAudience audience = ProfileAudience.requester;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is ProfileAudience) audience = arguments;
  }

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  Future<void> onSave() async {
    if (_isSaving) return;

    _isSaving = true;
    update([AppUpdateIds.privacySubmit]);
    try {
      await _repository.savePrivacy(
        const PrivacySettings(cityLevelLocationOnly: true),
      );
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    } finally {
      _isSaving = false;
      update([AppUpdateIds.privacySubmit]);
    }

    // Pop first: Get.back() would close an open snackbar instead of the route.
    Get.back<void>();
    AppSnackbar.show(AppStrings.privacySaved, type: AppSnackbarType.success);
  }

  void onBack() => Get.back<void>();
}
