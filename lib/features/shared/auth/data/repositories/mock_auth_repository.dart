import 'package:pocketwrench/features/shared/auth/data/models/auth_user.dart';
import 'package:pocketwrench/features/shared/auth/data/models/social_provider.dart';
import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';

/// In-memory stand-in that succeeds after a short delay.
class MockAuthRepository implements AuthRepository {
  static const Duration _latency = Duration(milliseconds: 900);

  Future<void> _simulateNetwork() => Future<void>.delayed(_latency);

  @override
  Future<AuthUser> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required UserRole role,
  }) async {
    await _simulateNetwork();
    return AuthUser(
      id: 'mock-user',
      fullName: fullName,
      email: email,
      role: role,
    );
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    await _simulateNetwork();
    return AuthUser(
      id: 'mock-user',
      fullName: 'Jane Doe',
      email: email,
      role: UserRole.vehicleOwner,
    );
  }

  @override
  Future<AuthUser> signInWithProvider(SocialProvider provider) async {
    await _simulateNetwork();
    return const AuthUser(
      id: 'mock-user',
      fullName: 'Jane Doe',
      email: 'jane@example.com',
      role: UserRole.vehicleOwner,
    );
  }

  @override
  Future<void> sendPasswordResetLink(String email) => _simulateNetwork();

  @override
  Future<void> resetPassword(String newPassword) => _simulateNetwork();

  @override
  Future<void> verifyOtp({required String phone, required String code}) =>
      _simulateNetwork();

  @override
  Future<void> resendOtp(String phone) => _simulateNetwork();

  @override
  Future<void> logout() => _simulateNetwork();
}
