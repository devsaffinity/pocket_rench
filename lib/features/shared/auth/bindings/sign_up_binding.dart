import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:pocketwrench/features/shared/auth/view_models/sign_up_view_model.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpViewModel>(
      () => SignUpViewModel(Get.find<AuthRepository>()),
    );
  }
}
