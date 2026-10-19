import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';

/// About Us. The links need a URL launcher or store-review package, which are
/// not approved yet, so each row shows a "coming soon" message.
class AboutViewModel extends GetxController {
  void onTerms() => _comingSoon();
  void onPrivacyPolicy() => _comingSoon();
  void onRate() => _comingSoon();
  void onContactSupport() => _comingSoon();

  void _comingSoon() => AppSnackbar.show(AppStrings.featureComingSoon);

  void onBack() => Get.back<void>();
}
