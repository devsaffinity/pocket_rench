import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/theme/app_system_ui.dart';
import 'package:pocketwrench/features/shared/welcome/view_models/welcome_view_model.dart';
import 'package:pocketwrench/features/shared/welcome/views/widgets/welcome_content.dart';
import 'package:pocketwrench/features/shared/welcome/views/widgets/welcome_hero.dart';

class WelcomeView extends GetView<WelcomeViewModel> {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.lightIcons,
      child: Scaffold(
        body: Column(
          children: [
            const WelcomeHero(),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: WelcomeContent(
                  onGetStarted: controller.onGetStarted,
                  onLogIn: controller.onLogIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
