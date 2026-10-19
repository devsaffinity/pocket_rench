import 'package:get/get.dart';
import 'package:pocketwrench/features/requester/onboarding/view_models/all_set_view_model.dart';

class AllSetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllSetViewModel>(AllSetViewModel.new);
  }
}
