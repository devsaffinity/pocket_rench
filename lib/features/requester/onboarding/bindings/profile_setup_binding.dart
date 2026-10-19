import 'package:get/get.dart';
import 'package:pocketwrench/features/requester/onboarding/data/repositories/mock_profile_repository.dart';
import 'package:pocketwrench/features/requester/onboarding/data/repositories/profile_repository.dart';
import 'package:pocketwrench/features/requester/onboarding/view_models/profile_setup_view_model.dart';

class ProfileSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileRepository>(MockProfileRepository.new);
    Get.lazyPut<ProfileSetupViewModel>(
      () => ProfileSetupViewModel(Get.find<ProfileRepository>()),
    );
  }
}
