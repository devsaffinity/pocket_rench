import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/features/shared/splash/data/models/splash_destination.dart';
import 'package:pocketwrench/features/shared/splash/data/repositories/splash_repository.dart';

/// Holds the splash on screen, then always continues to the welcome screen.
class MockSplashRepository implements SplashRepository {
  @override
  Future<SplashDestination> bootstrap() async {
    await Future<void>.delayed(AppDurations.splashHold);
    return SplashDestination.welcome;
  }
}
