import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/core/widgets/app_snackbar.dart';
import 'package:pocketwrench/features/shared/auth/data/models/auth_exception.dart';
import 'package:pocketwrench/features/shared/auth/data/models/social_provider.dart';
import 'package:pocketwrench/features/shared/auth/data/models/user_role.dart';
import 'package:pocketwrench/features/shared/auth/data/repositories/auth_repository.dart';

/// Shared behavior for auth screens that talk to [AuthRepository].
abstract class AuthViewModel extends GetxController {
  AuthViewModel(this.repository);

  @protected
  final AuthRepository repository;

  SocialProvider? _loadingProvider;
  SocialProvider? get loadingProvider => _loadingProvider;

  /// GetBuilder id for the social buttons on the screen.
  @protected
  String get socialUpdateId;

  /// Runs [task], turning failures into an error snackbar. Returns null when
  /// the task failed.
  @protected
  Future<T?> guard<T>(Future<T> Function() task) async {
    try {
      return await task();
    } on AuthException catch (error) {
      AppSnackbar.show(error.message, type: AppSnackbarType.error);
    } catch (_) {
      AppSnackbar.show(AppStrings.genericError, type: AppSnackbarType.error);
    }
    return null;
  }

  /// Like [guard] for tasks without a result. Returns whether [task] succeeded.
  @protected
  Future<bool> attempt(Future<void> Function() task) async {
    final result = await guard<bool>(() async {
      await task();
      return true;
    });
    return result ?? false;
  }

  /// First screen after a returning person signs in.
  @protected
  String homeRouteFor(UserRole role) => switch (role) {
    UserRole.vehicleOwner => AppRoutes.main,
    UserRole.mechanic => AppRoutes.mechanicHome,
  };

  Future<void> signInWithProvider(SocialProvider provider) async {
    if (_loadingProvider != null) return;

    _loadingProvider = provider;
    update([socialUpdateId]);
    final user = await guard(() => repository.signInWithProvider(provider));
    _loadingProvider = null;
    update([socialUpdateId]);

    if (user != null) await Get.offAllNamed<void>(homeRouteFor(user.role));
  }
}
