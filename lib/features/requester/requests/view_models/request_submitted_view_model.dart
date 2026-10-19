import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';

/// Confirmation after a request is sent: go home, or look for an expert.
class RequestSubmittedViewModel extends GetxController {
  RequestSubmittedViewModel({
    required VoidCallback onShowHome,
    required VoidCallback onShowExperts,
  }) : _onShowHome = onShowHome,
       _onShowExperts = onShowExperts;

  final VoidCallback _onShowHome;
  final VoidCallback _onShowExperts;

  void onGoHome() {
    _backToShell();
    _onShowHome();
  }

  void onFindExpert() {
    _backToShell();
    _onShowExperts();
  }

  void _backToShell() =>
      Get.until((route) => route.settings.name == AppRoutes.main);

  void onBack() => Get.back<void>();
}
