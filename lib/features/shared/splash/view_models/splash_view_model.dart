import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/view_state.dart';
import 'package:pocketwrench/features/shared/splash/data/models/splash_destination.dart';
import 'package:pocketwrench/features/shared/splash/data/repositories/splash_repository.dart';

class SplashViewModel extends GetxController {
  SplashViewModel(this._repository);

  final SplashRepository _repository;

  bool _isLogoVisible = false;
  bool get isLogoVisible => _isLogoVisible;

  ViewState _state = ViewState.idle;
  ViewState get state => _state;

  @override
  void onReady() {
    super.onReady();
    unawaited(_start());
  }

  Future<void> _start() async {
    _isLogoVisible = true;
    update([AppUpdateIds.splashLogo]);

    _state = ViewState.loading;
    var destination = SplashDestination.welcome;
    try {
      destination = await _repository.bootstrap();
      _state = ViewState.success;
    } catch (_) {
      // Startup failures must never trap the user on the splash screen.
      _state = ViewState.error;
    }

    await Get.offNamed<void>(_routeFor(destination));
  }

  String _routeFor(SplashDestination destination) => switch (destination) {
    SplashDestination.welcome => AppRoutes.welcome,
  };
}
