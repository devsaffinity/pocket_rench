import 'package:pocketwrench/core/constants/app_strings.dart';

/// Form validators. Return null when valid, otherwise an error message.
abstract final class Validators {
  static const int minPasswordLength = 8;
  static const int minPhoneDigits = 7;
  static const int maxPhoneDigits = 15;
  static final RegExp _email = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return AppStrings.fieldRequired;
    return null;
  }

  static String? email(String? value) {
    final error = required(value);
    if (error != null) return error;
    return _email.hasMatch(value!.trim()) ? null : AppStrings.emailInvalid;
  }

  static String? phone(String? value) {
    final error = required(value);
    if (error != null) return error;
    final digits = value!.replaceAll(RegExp(r'\D'), '');
    return digits.length >= minPhoneDigits && digits.length <= maxPhoneDigits
        ? null
        : AppStrings.phoneInvalid;
  }

  static String? password(String? value) {
    final error = required(value);
    if (error != null) return error;
    return value!.length >= minPasswordLength
        ? null
        : AppStrings.passwordTooShort;
  }
}
