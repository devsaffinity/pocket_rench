import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/validators.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/profile/data/repositories/account_repository.dart';

/// Update Password: current, new and confirmation.
class ChangePasswordViewModel extends GetxController {
  ChangePasswordViewModel(this._repository);

  final AccountRepository _repository;

  final TextEditingController currentController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool _hideCurrent = true;
  bool get hideCurrent => _hideCurrent;
  bool _hideNew = true;
  bool get hideNew => _hideNew;
  bool _hideConfirm = true;
  bool get hideConfirm => _hideConfirm;

  String? _currentError;
  String? get currentError => _currentError;
  String? _newError;
  String? get newError => _newError;
  String? _confirmError;
  String? get confirmError => _confirmError;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([
      currentController,
      newController,
      confirmController,
    ]);
    super.onClose();
  }

  void toggleCurrent() {
    _hideCurrent = !_hideCurrent;
    update([AppUpdateIds.passwordCurrentField]);
  }

  void toggleNew() {
    _hideNew = !_hideNew;
    update([AppUpdateIds.passwordNewField]);
  }

  void toggleConfirm() {
    _hideConfirm = !_hideConfirm;
    update([AppUpdateIds.passwordConfirmField]);
  }

  void onCurrentChanged(String _) {
    if (_currentError == null) return;
    _currentError = null;
    update([AppUpdateIds.passwordCurrentField]);
  }

  void onNewChanged(String _) {
    if (_newError == null) return;
    _newError = null;
    update([AppUpdateIds.passwordNewField]);
  }

  void onConfirmChanged(String _) {
    if (_confirmError == null) return;
    _confirmError = null;
    update([AppUpdateIds.passwordConfirmField]);
  }

  Future<void> onSave() async {
    if (_isSaving) return;

    _currentError = Validators.required(currentController.text);
    _newError = Validators.password(newController.text);
    _confirmError = confirmController.text != newController.text
        ? AppStrings.passwordsDoNotMatch
        : Validators.required(confirmController.text);
    update([
      AppUpdateIds.passwordCurrentField,
      AppUpdateIds.passwordNewField,
      AppUpdateIds.passwordConfirmField,
    ]);
    if (_currentError != null || _newError != null || _confirmError != null) {
      return;
    }

    _isSaving = true;
    update([AppUpdateIds.passwordSubmit]);
    try {
      await _repository.changePassword(
        current: currentController.text,
        next: newController.text,
      );
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
      return;
    } finally {
      _isSaving = false;
      update([AppUpdateIds.passwordSubmit]);
    }

    // Pop first: Get.back() would close an open snackbar instead of the route.
    Get.back<void>();
    AppSnackbar.show(AppStrings.passwordUpdated, type: AppSnackbarType.success);
  }

  void onBack() => Get.back<void>();
}
