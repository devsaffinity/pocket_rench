import 'package:get/get.dart';
import 'package:pocketwrench/features/requester/main/view_models/main_shell_view_model.dart';
import 'package:pocketwrench/features/requester/requests/view_models/request_submitted_view_model.dart';

class RequestSubmittedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestSubmittedViewModel>(
      () => RequestSubmittedViewModel(
        onShowHome: () => Get.find<MainShellViewModel>().selectTab(
          MainShellViewModel.homeTab,
        ),
        onShowExperts: () => Get.find<MainShellViewModel>().selectTab(
          MainShellViewModel.exploreTab,
        ),
      ),
    );
  }
}
