import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/validators.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';
import 'package:pocketwrench/features/shared/auth/data/models/verify_otp_args.dart';
import 'package:pocketwrench/features/shared/auth/view_models/auth_view_model.dart';

class SignUpViewModel extends AuthViewModel {
  SignUpViewModel(super.repository);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  UserRole _role = UserRole.vehicleOwner;

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  bool _hasAgreed = false;
  bool get hasAgreed => _hasAgreed;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _nameError;
  String? get nameError => _nameError;
  String? _emailError;
  String? get emailError => _emailError;
  String? _phoneError;
  String? get phoneError => _phoneError;
  String? _passwordError;
  String? get passwordError => _passwordError;

  @override
  String get socialUpdateId => AppUpdateIds.signUpSocial;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is UserRole) _role = arguments;
  }

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([
      nameController,
      emailController,
      phoneController,
      passwordController,
      nameFocus,
      emailFocus,
      phoneFocus,
      passwordFocus,
    ]);
    super.onClose();
  }

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    update([AppUpdateIds.signUpPasswordField]);
  }

  void toggleAgreement(bool value) {
    _hasAgreed = value;
    update([AppUpdateIds.signUpAgree]);
  }

  void onNameChanged(String _) => _clearError(
    _nameError,
    () => _nameError = null,
    AppUpdateIds.signUpNameField,
  );

  void onEmailChanged(String _) => _clearError(
    _emailError,
    () => _emailError = null,
    AppUpdateIds.signUpEmailField,
  );

  void onPhoneChanged(String _) => _clearError(
    _phoneError,
    () => _phoneError = null,
    AppUpdateIds.signUpPhoneField,
  );

  void onPasswordChanged(String _) => _clearError(
    _passwordError,
    () => _passwordError = null,
    AppUpdateIds.signUpPasswordField,
  );

  void _clearError(String? current, VoidCallback clear, String id) {
    if (current == null) return;
    clear();
    update([id]);
  }

  bool _validate() {
    _nameError = Validators.required(nameController.text);
    _emailError = Validators.email(emailController.text);
    _phoneError = Validators.phone(phoneController.text);
    _passwordError = Validators.password(passwordController.text);
    update([
      AppUpdateIds.signUpNameField,
      AppUpdateIds.signUpEmailField,
      AppUpdateIds.signUpPhoneField,
      AppUpdateIds.signUpPasswordField,
    ]);

    return _nameError == null &&
        _emailError == null &&
        _phoneError == null &&
        _passwordError == null;
  }

  Future<void> onSubmit() async {
    if (_isLoading || !_validate()) return;
    if (!_hasAgreed) {
      AppSnackbar.show(AppStrings.termsRequired, type: AppSnackbarType.error);
      return;
    }

    _isLoading = true;
    update([AppUpdateIds.signUpSubmit]);
    final phone = phoneController.text.trim();
    final user = await guard(
      () => repository.signUp(
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phone,
        password: passwordController.text,
        role: _role,
      ),
    );
    _isLoading = false;
    update([AppUpdateIds.signUpSubmit]);

    if (user != null) {
      await Get.toNamed<void>(
        AppRoutes.verifyOtp,
        arguments: VerifyOtpArgs(phone: phone, role: _role),
      );
    }
  }

  Future<void> onSignIn() async {
    await Get.offNamed<void>(AppRoutes.login);
  }
}
