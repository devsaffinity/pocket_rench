import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/privacy_settings_view_model.dart';

class PrivacySettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacySettingsViewModel>(
      () => PrivacySettingsViewModel(Get.find<AccountRepository>()),
    );
  }
}
