import 'package:get/get.dart';
import 'package:pocketwrench/features/requester/mechanics/data/repositories/mechanic_repository.dart';
import 'package:pocketwrench/features/requester/mechanics/view_models/mechanic_profile_view_model.dart';
import 'package:pocketwrench/features/requester/requests/data/repositories/request_repository.dart';

class MechanicProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MechanicProfileViewModel>(
      () => MechanicProfileViewModel(
        Get.find<MechanicRepository>(),
        Get.find<RequestRepository>(),
      ),
    );
  }
}
