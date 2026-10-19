import 'package:get/get.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/verification_status_view_model.dart';

class VerificationStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationStatusViewModel>(
      () => VerificationStatusViewModel(Get.find<MechanicProfileRepository>()),
    );
  }
}
