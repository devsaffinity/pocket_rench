import 'package:get/get.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/professional_profile_view_model.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';

class ProfessionalProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfessionalProfileViewModel>(
      () => ProfessionalProfileViewModel(
        Get.find<MechanicProfileRepository>(),
        Get.find<AccountRepository>(),
      ),
    );
  }
}
