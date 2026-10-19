import 'package:pocketwrench/features/mechanic/onboarding/data/models/mechanic_onboarding_draft.dart';
import 'package:pocketwrench/features/mechanic/onboarding/data/repositories/mechanic_onboarding_repository.dart';

/// Accepts every submission after a short delay.
class MockMechanicOnboardingRepository implements MechanicOnboardingRepository {
  static const Duration _latency = Duration(milliseconds: 800);

  @override
  Future<void> submit(MechanicOnboardingDraft draft) =>
      Future<void>.delayed(_latency);
}
