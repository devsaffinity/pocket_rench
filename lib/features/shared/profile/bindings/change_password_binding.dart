import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/change_password_view_model.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordViewModel>(
      () => ChangePasswordViewModel(Get.find<AccountRepository>()),
    );
  }
}
