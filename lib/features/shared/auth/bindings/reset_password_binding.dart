import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:pocketwrench/features/shared/auth/view_models/reset_password_view_model.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordViewModel>(
      () => ResetPasswordViewModel(Get.find<AuthRepository>()),
    );
  }
}
