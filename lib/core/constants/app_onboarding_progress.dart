/// Progress shown on each mechanic onboarding step: the percentage in the
/// label and how much of the bar is filled. The design draws the fill a little
/// longer than the percentage, so both are kept as drawn.
abstract final class AppOnboardingProgress {
  static const int experiencePercent = 20;
  static const double experienceFill = 0.19;

  static const int vehiclesPercent = 40;
  static const double vehiclesFill = 0.474;

  static const int expertisePercent = 60;
  static const double expertiseFill = 0.734;

  static const int verificationPercent = 60;
  static const double verificationFill = 0.734;
}
