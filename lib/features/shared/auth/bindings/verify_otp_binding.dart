import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';
import 'package:pocketwrench/features/shared/auth/view_models/verify_otp_view_model.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOtpViewModel>(
      () => VerifyOtpViewModel(Get.find<AuthRepository>()),
    );
  }
}
