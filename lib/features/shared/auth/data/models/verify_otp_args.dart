import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';

/// What the verification screen needs from sign up.
class VerifyOtpArgs {
  const VerifyOtpArgs({required this.phone, required this.role});

  final String phone;
  final UserRole role;
}
