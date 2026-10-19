import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/notification_settings_view_model.dart';

class NotificationSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationSettingsViewModel>(
      () => NotificationSettingsViewModel(Get.find<AccountRepository>()),
    );
  }
}
