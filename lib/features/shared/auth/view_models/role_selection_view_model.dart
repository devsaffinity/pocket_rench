import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';

class RoleSelectionViewModel extends GetxController {
  UserRole _selectedRole = UserRole.vehicleOwner;
  UserRole get selectedRole => _selectedRole;

  void selectRole(UserRole role) {
    if (role == _selectedRole) return;
    _selectedRole = role;
    update([AppUpdateIds.roleCards]);
  }

  Future<void> onContinue() async {
    await Get.toNamed<void>(AppRoutes.signUp, arguments: _selectedRole);
  }

  void onBack() => Get.back<void>();
}
