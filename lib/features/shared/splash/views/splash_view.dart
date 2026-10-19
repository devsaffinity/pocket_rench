import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/features/shared/splash/view_models/splash_view_model.dart';
import 'package:pocketwrench/features/shared/splash/views/widgets/splash_logo.dart';

class SplashView extends GetView<SplashViewModel> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIcons,
      child: Scaffold(
        body: Center(
          child: GetBuilder<SplashViewModel>(
            id: AppUpdateIds.splashLogo,
            builder: (vm) => AnimatedOpacity(
              opacity: vm.isLogoVisible ? 1 : 0,
              duration: AppDurations.logoFadeIn,
              curve: AppDurations.standardCurve,
              child: const SplashLogo(),
            ),
          ),
        ),
      ),
    );
  }
}
