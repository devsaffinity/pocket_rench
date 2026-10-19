import 'package:get/get.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';
import 'package:pocketwrench/features/mechanic/profile/view_models/pricing_view_model.dart';

class PricingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PricingViewModel>(
      () => PricingViewModel(Get.find<MechanicProfileRepository>()),
    );
  }
}
