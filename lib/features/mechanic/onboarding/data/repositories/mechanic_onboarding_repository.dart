import 'package:pocketwrench/features/mechanic/onboarding/data/models/mechanic_onboarding_draft.dart';

/// Sends a mechanic's onboarding answers for review.
abstract class MechanicOnboardingRepository {
  Future<void> submit(MechanicOnboardingDraft draft);
}
