import 'dart:async';

import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/requester/onboarding/data/repositories/profile_repository.dart';

class ProfileSetupViewModel extends GetxController {
  ProfileSetupViewModel(this._repository);

  final ProfileRepository _repository;

  List<String> _cities = const [];
  List<String> get cities => _cities;

  String? _city;
  String? get city => _city;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    unawaited(_loadCities());
  }

  Future<void> _loadCities() async {
    _cities = await _repository.loadCities();
    update([AppUpdateIds.profileLocation]);
  }

  void selectCity(String city) {
    _city = city;
    update([AppUpdateIds.profileLocation]);
  }

  /// Uploading needs a file or image picker package, which is not approved yet.
  void onBrowseFiles() {
    AppSnackbar.show(AppStrings.photoPickerUnavailable);
  }

  Future<void> onNext() async {
    if (_isLoading) return;

    _isLoading = true;
    update([AppUpdateIds.profileSubmit]);
    try {
      await _repository.saveProfile(city: _city);
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    } finally {
      _isLoading = false;
      update([AppUpdateIds.profileSubmit]);
    }

    await Get.toNamed<void>(AppRoutes.allSet);
  }

  void onBack() => Get.back<void>();
}
