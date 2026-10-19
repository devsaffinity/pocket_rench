import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/auth/view_models/role_selection_view_model.dart';

class RoleSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoleSelectionViewModel>(RoleSelectionViewModel.new);
  }
}
