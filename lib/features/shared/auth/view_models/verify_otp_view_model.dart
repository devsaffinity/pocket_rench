import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';
import 'package:pocketwrench/features/shared/auth/data/models/verify_otp_args.dart';
import 'package:pocketwrench/features/shared/auth/view_models/auth_view_model.dart';

class VerifyOtpViewModel extends AuthViewModel {
  VerifyOtpViewModel(super.repository);

  static const int codeLength = 6;

  /// Receives the typed digits. The boxes only display them.
  final TextEditingController codeController = TextEditingController();
  final FocusNode codeFocus = FocusNode();

  String _phone = '';
  String get phone => _phone;

  UserRole _role = UserRole.vehicleOwner;

  String _code = '';
  String get code => _code;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// This screen has no social buttons, so the id is never rebuilt.
  @override
  String get socialUpdateId => AppUpdateIds.otpSubmit;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is VerifyOtpArgs) {
      _phone = arguments.phone;
      _role = arguments.role;
    }
  }

  @override
  void onReady() {
    super.onReady();
    codeFocus.requestFocus();
  }

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([codeController, codeFocus]);
    super.onClose();
  }

  void onCodeChanged(String value) {
    _code = value;
    update([AppUpdateIds.otpBoxes]);
  }

  void focusCode() => codeFocus.requestFocus();

  Future<void> onSubmit() async {
    if (_isLoading) return;
    if (_code.length < codeLength) {
      AppSnackbar.show(AppStrings.otpIncomplete, type: AppSnackbarType.error);
      return;
    }

    _isLoading = true;
    update([AppUpdateIds.otpSubmit]);
    final verified = await attempt(
      () => repository.verifyOtp(phone: _phone, code: _code),
    );
    _isLoading = false;
    update([AppUpdateIds.otpSubmit]);

    if (!verified) return;
    switch (_role) {
      case UserRole.vehicleOwner:
        await Get.toNamed<void>(AppRoutes.profileSetup);
      case UserRole.mechanic:
        await Get.toNamed<void>(AppRoutes.mechanicExperience);
    }
  }

  Future<void> onResend() async {
    final sent = await attempt(() => repository.resendOtp(_phone));
    if (sent) {
      AppSnackbar.show(AppStrings.codeResent, type: AppSnackbarType.success);
    }
  }

  void onChangeContact() => Get.back<void>();
}
