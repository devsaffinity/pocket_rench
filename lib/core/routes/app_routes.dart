/// Route name constants.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';

  // Auth
  static const String roleSelection = '/auth/role';
  static const String signUp = '/auth/sign-up';
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyOtp = '/auth/verify-otp';

  // Requester onboarding
  static const String profileSetup = '/onboarding/profile';
  static const String allSet = '/onboarding/all-set';

  // Signed-in shell (bottom navigation)
  static const String main = '/main';

  static const String mechanicProfile = '/mechanics/profile';
  static const String chat = '/messages/chat';

  // New request flow
  static const String newRequestDetails = '/requests/new/details';
  static const String newRequestFiles = '/requests/new/files';
  static const String newRequestReview = '/requests/new/review';
  static const String requestDescription = '/requests/new/description';
  static const String requestSubmitted = '/requests/new/submitted';

  // Profile
  static const String editProfile = '/profile/edit';
  static const String changePassword = '/profile/password';
  static const String notificationSettings = '/profile/notifications';
  static const String privacySettings = '/profile/privacy';
  static const String about = '/profile/about';

  // Mechanic onboarding
  static const String mechanicExperience = '/mechanic/onboarding/experience';
  static const String mechanicVehicles = '/mechanic/onboarding/vehicles';
  static const String mechanicExpertise = '/mechanic/onboarding/expertise';
  static const String mechanicVerification =
      '/mechanic/onboarding/verification';
  static const String mechanicSubmitted = '/mechanic/onboarding/submitted';

  // Mechanic settings
  static const String professionalProfile = '/mechanic/profile/professional';
  static const String verificationStatus = '/mechanic/profile/verification';
  static const String servicePricing = '/mechanic/profile/pricing';
  static const String certifications = '/mechanic/profile/certifications';

  // Mechanic requests
  static const String serviceRequestDetail = '/mechanic/requests/detail';

  // Mechanic flow (not designed yet)
  static const String mechanicHome = '/mechanic';
}
