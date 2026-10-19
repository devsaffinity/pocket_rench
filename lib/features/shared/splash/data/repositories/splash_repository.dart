import 'package:pocketwrench/features/shared/splash/data/models/splash_destination.dart';

/// Startup work (session restore, remote config) that decides the first screen.
abstract class SplashRepository {
  Future<SplashDestination> bootstrap();
}
