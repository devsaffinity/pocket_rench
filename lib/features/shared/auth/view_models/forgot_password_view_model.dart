import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/validators.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/auth/view_models/auth_view_model.dart';

class ForgotPasswordViewModel extends AuthViewModel {
  ForgotPasswordViewModel(super.repository);

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _emailError;
  String? get emailError => _emailError;

  /// This screen has no social buttons, so the id is never rebuilt.
  @override
  String get socialUpdateId => AppUpdateIds.forgotSubmit;

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([emailController, emailFocus]);
    super.onClose();
  }

  void onEmailChanged(String _) {
    if (_emailError == null) return;
    _emailError = null;
    update([AppUpdateIds.forgotEmailField]);
  }

  Future<void> onSubmit() async {
    if (_isLoading) return;
    _emailError = Validators.email(emailController.text);
    update([AppUpdateIds.forgotEmailField]);
    if (_emailError != null) return;

    _isLoading = true;
    update([AppUpdateIds.forgotSubmit]);
    final sent = await attempt(
      () => repository.sendPasswordResetLink(emailController.text.trim()),
    );
    _isLoading = false;
    update([AppUpdateIds.forgotSubmit]);

    if (!sent) return;
    AppSnackbar.show(AppStrings.resetLinkSent, type: AppSnackbarType.success);
    // Stand-in for opening the emailed link, which would deep-link here.
    await Get.toNamed<void>(AppRoutes.resetPassword);
  }

  void onBackToLogin() => Get.back<void>();
}
