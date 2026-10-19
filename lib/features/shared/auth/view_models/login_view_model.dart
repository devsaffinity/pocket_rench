import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_update_ids.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/utils/helpers.dart';
import 'package:pocketwrench/core/utils/validators.dart';
import 'package:pocketwrench/features/shared/auth/view_models/auth_view_model.dart';

class LoginViewModel extends AuthViewModel {
  LoginViewModel(super.repository);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;

  bool _rememberMe = true;
  bool get rememberMe => _rememberMe;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _emailError;
  String? get emailError => _emailError;
  String? _passwordError;
  String? get passwordError => _passwordError;

  @override
  String get socialUpdateId => AppUpdateIds.loginSocial;

  @override
  void onClose() {
    AppHelpers.disposeAfterFrame([
      emailController,
      passwordController,
      emailFocus,
      passwordFocus,
    ]);
    super.onClose();
  }

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    update([AppUpdateIds.loginPasswordField]);
  }

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    update([AppUpdateIds.loginRemember]);
  }

  void onEmailChanged(String _) {
    if (_emailError == null) return;
    _emailError = null;
    update([AppUpdateIds.loginEmailField]);
  }

  void onPasswordChanged(String _) {
    if (_passwordError == null) return;
    _passwordError = null;
    update([AppUpdateIds.loginPasswordField]);
  }

  bool _validate() {
    _emailError = Validators.email(emailController.text);
    _passwordError = Validators.required(passwordController.text);
    update([AppUpdateIds.loginEmailField, AppUpdateIds.loginPasswordField]);
    return _emailError == null && _passwordError == null;
  }

  Future<void> onSubmit() async {
    if (_isLoading || !_validate()) return;

    _isLoading = true;
    update([AppUpdateIds.loginSubmit]);
    final user = await guard(
      () => repository.login(
        email: emailController.text.trim(),
        password: passwordController.text,
        rememberMe: _rememberMe,
      ),
    );
    _isLoading = false;
    update([AppUpdateIds.loginSubmit]);

    if (user != null) await Get.offAllNamed<void>(homeRouteFor(user.role));
  }

  Future<void> onForgotPassword() async {
    await Get.toNamed<void>(AppRoutes.forgotPassword);
  }

  Future<void> onSignUp() async {
    await Get.offNamed<void>(AppRoutes.roleSelection);
  }
}
