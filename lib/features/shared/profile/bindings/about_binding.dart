import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/profile/view_models/about_view_model.dart';

class AboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutViewModel>(AboutViewModel.new);
  }
}
