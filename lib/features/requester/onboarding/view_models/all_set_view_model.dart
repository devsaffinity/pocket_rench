import 'package:get/get.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';

class AllSetViewModel extends GetxController {
  Future<void> onGetStarted() async {
    await Get.offAllNamed<void>(AppRoutes.main);
  }

  void onBack() => Get.back<void>();
}
