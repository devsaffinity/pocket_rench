import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/validators.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/auth/view_models/auth_view_model.dart';

class ResetPasswordViewModel extends AuthViewModel {
  ResetPasswordViewModel(super.repository);

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final FocusNode newPasswordFocus = FocusNode();
  final FocusNode confirmFocus = FocusNode();

  bool _isNewHidden = true;
  bool get isNewHidden => _isNewHidden;
  bool _isConfirmHidden = true;
  bool get isConfirmHidden => _isConfirmHidden;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _newError;
  String? get newError => _newError;
  String? _confirmError;
  String? get confirmError => _confirmError;

  /// This screen has no social buttons, so the id is never rebuilt.
  @override
  String get socialUpdateId => AppUpdateIds.resetSubmit;

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([
      newPasswordController,
      confirmController,
      newPasswordFocus,
      confirmFocus,
    ]);
    super.onClose();
  }

  void toggleNewVisibility() {
    _isNewHidden = !_isNewHidden;
    update([AppUpdateIds.resetNewField]);
  }

  void toggleConfirmVisibility() {
    _isConfirmHidden = !_isConfirmHidden;
    update([AppUpdateIds.resetConfirmField]);
  }

  void onNewChanged(String _) {
    if (_newError == null) return;
    _newError = null;
    update([AppUpdateIds.resetNewField]);
  }

  void onConfirmChanged(String _) {
    if (_confirmError == null) return;
    _confirmError = null;
    update([AppUpdateIds.resetConfirmField]);
  }

  bool _validate() {
    _newError = Validators.password(newPasswordController.text);
    _confirmError = confirmController.text != newPasswordController.text
        ? AppStrings.passwordsDoNotMatch
        : null;
    update([AppUpdateIds.resetNewField, AppUpdateIds.resetConfirmField]);
    return _newError == null && _confirmError == null;
  }

  Future<void> onSubmit() async {
    if (_isLoading || !_validate()) return;

    _isLoading = true;
    update([AppUpdateIds.resetSubmit]);
    final done = await attempt(
      () => repository.resetPassword(newPasswordController.text),
    );
    _isLoading = false;
    update([AppUpdateIds.resetSubmit]);

    if (!done) return;
    AppSnackbar.show(
      AppStrings.passwordResetDone,
      type: AppSnackbarType.success,
    );
    await Get.offAllNamed<void>(AppRoutes.login);
  }
}
