import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/welcome/view_models/welcome_view_model.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeViewModel>(WelcomeViewModel.new);
  }
}
