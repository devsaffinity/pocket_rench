import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';
import 'package:pocketwrench/features/shared/profile/view_models/edit_profile_view_model.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileViewModel>(
      () => EditProfileViewModel(Get.find<AccountRepository>()),
    );
  }
}
