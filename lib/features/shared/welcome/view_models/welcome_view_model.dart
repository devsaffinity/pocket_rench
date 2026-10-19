import 'package:get/get.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';

class WelcomeViewModel extends GetxController {
  Future<void> onGetStarted() async {
    await Get.toNamed<void>(AppRoutes.roleSelection);
  }

  Future<void> onLogIn() async {
    await Get.toNamed<void>(AppRoutes.login);
  }
}
