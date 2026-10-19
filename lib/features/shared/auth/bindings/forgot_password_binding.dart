import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:pocketwrench/features/shared/auth/view_models/forgot_password_view_model.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordViewModel>(
      () => ForgotPasswordViewModel(Get.find<AuthRepository>()),
    );
  }
}
