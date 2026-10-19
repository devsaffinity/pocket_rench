import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';

class AuthUser {
  const AuthUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
  });

  final String id;
  final String fullName;
  final String email;
  final UserRole role;
}
