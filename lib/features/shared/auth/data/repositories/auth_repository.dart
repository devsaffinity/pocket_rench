import 'package:pocketwrench/features/shared/auth/data/models/auth_user.dart';
import 'package:pocketwrench/features/shared/auth/data/models/social_provider.dart';
import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';

/// Authentication backend. Methods throw `AuthException` for failures the
/// user can act on.
abstract class AuthRepository {
  Future<AuthUser> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  });

  Future<AuthUser> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<AuthUser> signInWithProvider(SocialProvider provider);

  Future<void> sendPasswordResetLink(String email);

  Future<void> resetPassword(String newPassword);

  Future<void> verifyOtp({required String phone, required String code});

  Future<void> resendOtp(String phone);

  /// Ends the current session.
  Future<void> logout();
}
