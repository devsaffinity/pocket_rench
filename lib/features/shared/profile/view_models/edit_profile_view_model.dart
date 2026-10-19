import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/validators.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/profile/data/models/account.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';

/// Edit Profile: display name, birth date, email, phone and location.
class EditProfileViewModel extends GetxController {
  EditProfileViewModel(this._repository);

  final AccountRepository _repository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Account? _account;
  Account? get account => _account;

  DateTime? _birthDate;
  DateTime? get birthDate => _birthDate;

  String? _city;
  String? get city => _city;

  List<String> _cities = const [];
  List<String> get cities => _cities;

  String? _nameError;
  String? get nameError => _nameError;
  String? _emailError;
  String? get emailError => _emailError;
  String? _phoneError;
  String? get phoneError => _phoneError;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  @override
  void onInit() {
    super.onInit();
    unawaited(_load());
  }

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([
      nameController,
      emailController,
      phoneController,
    ]);
    super.onClose();
  }

  Future<void> _load() async {
    final account = await _repository.loadAccount();
    _cities = await _repository.loadCities();
    _account = account;
    nameController.text = account.name;
    emailController.text = account.email;
    phoneController.text = account.phone;
    _birthDate = account.birthDate;
    _city = account.city;
    update([
      AppUpdateIds.editProfileAvatar,
      AppUpdateIds.editProfileBirthDate,
      AppUpdateIds.editProfileLocation,
    ]);
  }

  void onNameChanged(String _) {
    if (_nameError == null) return;
    _nameError = null;
    update([AppUpdateIds.editProfileName]);
  }

  void onEmailChanged(String _) {
    if (_emailError == null) return;
    _emailError = null;
    update([AppUpdateIds.editProfileEmail]);
  }

  void onPhoneChanged(String _) {
    if (_phoneError == null) return;
    _phoneError = null;
    update([AppUpdateIds.editProfilePhone]);
  }

  void selectBirthDate(DateTime date) {
    _birthDate = date;
    update([AppUpdateIds.editProfileBirthDate]);
  }

  void selectCity(String city) {
    _city = city;
    update([AppUpdateIds.editProfileLocation]);
  }

  /// Changing the photo needs an image picker package, which is not approved.
  void onChangePhoto() => AppSnackbar.show(AppStrings.photoPickerUnavailable);

  Future<void> onSave() async {
    final account = _account;
    if (_isSaving || account == null) return;

    _nameError = Validators.required(nameController.text);
    _emailError = Validators.email(emailController.text);
    _phoneError = Validators.phone(phoneController.text);
    update([
      AppUpdateIds.editProfileName,
      AppUpdateIds.editProfileEmail,
      AppUpdateIds.editProfilePhone,
    ]);
    if (_nameError != null || _emailError != null || _phoneError != null) {
      return;
    }

    _isSaving = true;
    update([AppUpdateIds.editProfileSubmit]);
    try {
      await _repository.saveAccount(
        account.copyWith(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          phone: phoneController.text.trim(),
          birthDate: _birthDate,
          city: _city,
        ),
      );
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    } finally {
      _isSaving = false;
      update([AppUpdateIds.editProfileSubmit]);
    }

    // Pop first: Get.back() would close an open snackbar instead of the route.
    Get.back<void>();
    AppSnackbar.show(AppStrings.profileSaved, type: AppSnackbarType.success);
  }

  void onBack() => Get.back<void>();
}
