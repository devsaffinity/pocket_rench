import 'package:get/get.dart';
import 'package:pocketwrench/features/shared/splash/data/repositories/mock_splash_repository.dart';
import 'package:pocketwrench/features/shared/splash/data/repositories/splash_repository.dart';
import 'package:pocketwrench/features/shared/splash/view_models/splash_view_model.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashRepository>(MockSplashRepository.new);
    Get.lazyPut<SplashViewModel>(
      () => SplashViewModel(Get.find<SplashRepository>()),
    );
  }
}
