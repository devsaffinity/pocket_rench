import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/features/mechanic/main/bindings/mechanic_main_binding.dart';
import 'package:pocketwrench/features/mechanic/main/views/mechanic_shell_view.dart';
import 'package:pocketwrench/features/mechanic/onboarding/bindings/mechanic_onboarding_binding.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/experience_view.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/expertise_view.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/vehicles_view.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/verification_submitted_view.dart';
import 'package:pocketwrench/features/mechanic/onboarding/views/verification_view.dart';
import 'package:pocketwrench/features/mechanic/profile/bindings/certifications_binding.dart';
import 'package:pocketwrench/features/mechanic/profile/bindings/pricing_binding.dart';
import 'package:pocketwrench/features/mechanic/profile/bindings/professional_profile_binding.dart';
import 'package:pocketwrench/features/mechanic/profile/bindings/verification_status_binding.dart';
import 'package:pocketwrench/features/mechanic/profile/views/certifications_view.dart';
import 'package:pocketwrench/features/mechanic/profile/views/pricing_view.dart';
import 'package:pocketwrench/features/mechanic/profile/views/professional_profile_view.dart';
import 'package:pocketwrench/features/mechanic/profile/views/verification_status_view.dart';
import 'package:pocketwrench/features/mechanic/requests/bindings/service_request_detail_binding.dart';
import 'package:pocketwrench/features/mechanic/requests/views/service_request_detail_view.dart';
import 'package:pocketwrench/features/requester/main/bindings/main_binding.dart';
import 'package:pocketwrench/features/requester/main/views/main_shell_view.dart';
import 'package:pocketwrench/features/requester/mechanics/bindings/mechanic_profile_binding.dart';
import 'package:pocketwrench/features/requester/mechanics/views/mechanic_profile_view.dart';
import 'package:pocketwrench/features/requester/onboarding/bindings/all_set_binding.dart';
import 'package:pocketwrench/features/requester/onboarding/bindings/profile_setup_binding.dart';
import 'package:pocketwrench/features/requester/onboarding/views/all_set_view.dart';
import 'package:pocketwrench/features/requester/onboarding/views/profile_setup_view.dart';
import 'package:pocketwrench/features/requester/requests/bindings/new_request_binding.dart';
import 'package:pocketwrench/features/requester/requests/bindings/request_submitted_binding.dart';
import 'package:pocketwrench/features/requester/requests/views/new_request_details_view.dart';
import 'package:pocketwrench/features/requester/requests/views/new_request_files_view.dart';
import 'package:pocketwrench/features/requester/requests/views/new_request_review_view.dart';
import 'package:pocketwrench/features/requester/requests/views/request_description_view.dart';
import 'package:pocketwrench/features/requester/requests/views/request_submitted_view.dart';
import 'package:pocketwrench/features/shared/auth/bindings/forgot_password_binding.dart';
import 'package:pocketwrench/features/shared/auth/bindings/login_binding.dart';
import 'package:pocketwrench/features/shared/auth/bindings/reset_password_binding.dart';
import 'package:pocketwrench/features/shared/auth/bindings/role_selection_binding.dart';
import 'package:pocketwrench/features/shared/auth/bindings/sign_up_binding.dart';
import 'package:pocketwrench/features/shared/auth/bindings/verify_otp_binding.dart';
import 'package:pocketwrench/features/shared/auth/views/forgot_password_view.dart';
import 'package:pocketwrench/features/shared/auth/views/login_view.dart';
import 'package:pocketwrench/features/shared/auth/views/reset_password_view.dart';
import 'package:pocketwrench/features/shared/auth/views/role_selection_view.dart';
import 'package:pocketwrench/features/shared/auth/views/sign_up_view.dart';
import 'package:pocketwrench/features/shared/auth/views/verify_otp_view.dart';
import 'package:pocketwrench/features/shared/messages/bindings/chat_binding.dart';
import 'package:pocketwrench/features/shared/messages/views/chat_view.dart';
import 'package:pocketwrench/features/shared/profile/bindings/about_binding.dart';
import 'package:pocketwrench/features/shared/profile/bindings/change_password_binding.dart';
import 'package:pocketwrench/features/shared/profile/bindings/edit_profile_binding.dart';
import 'package:pocketwrench/features/shared/profile/bindings/notification_settings_binding.dart';
import 'package:pocketwrench/features/shared/profile/bindings/privacy_settings_binding.dart';
import 'package:pocketwrench/features/shared/profile/views/about_view.dart';
import 'package:pocketwrench/features/shared/profile/views/change_password_view.dart';
import 'package:pocketwrench/features/shared/profile/views/edit_profile_view.dart';
import 'package:pocketwrench/features/shared/profile/views/notification_settings_view.dart';
import 'package:pocketwrench/features/shared/profile/views/privacy_settings_view.dart';
import 'package:pocketwrench/features/shared/splash/bindings/splash_binding.dart';
import 'package:pocketwrench/features/shared/splash/views/splash_view.dart';
import 'package:pocketwrench/features/shared/welcome/bindings/welcome_binding.dart';
import 'package:pocketwrench/features/shared/welcome/views/welcome_view.dart';

/// Route table. Every route declares its own transition.
abstract final class AppPages {
  static GetPage<dynamic> _page({
    required String name,
    required GetPageBuilder page,
    Bindings? binding,
    Transition transition = Transition.rightToLeftWithFade,
  }) {
    return GetPage<dynamic>(
      name: name,
      page: page,
      binding: binding,
      transition: transition,
      transitionDuration: AppDurations.pageTransition,
      curve: AppDurations.pageCurve,
    );
  }

  static final List<GetPage<dynamic>> pages = [
    _page(
      name: AppRoutes.splash,
      page: SplashView.new,
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),
    _page(
      name: AppRoutes.welcome,
      page: WelcomeView.new,
      binding: WelcomeBinding(),
      transition: Transition.fadeIn,
    ),
    _page(
      name: AppRoutes.roleSelection,
      page: RoleSelectionView.new,
      binding: RoleSelectionBinding(),
    ),
    _page(
      name: AppRoutes.signUp,
      page: SignUpView.new,
      binding: SignUpBinding(),
    ),
    _page(name: AppRoutes.login, page: LoginView.new, binding: LoginBinding()),
    _page(
      name: AppRoutes.forgotPassword,
      page: ForgotPasswordView.new,
      binding: ForgotPasswordBinding(),
    ),
    _page(
      name: AppRoutes.resetPassword,
      page: ResetPasswordView.new,
      binding: ResetPasswordBinding(),
    ),
    _page(
      name: AppRoutes.verifyOtp,
      page: VerifyOtpView.new,
      binding: VerifyOtpBinding(),
    ),
    _page(
      name: AppRoutes.profileSetup,
      page: ProfileSetupView.new,
      binding: ProfileSetupBinding(),
    ),
    _page(
      name: AppRoutes.allSet,
      page: AllSetView.new,
      binding: AllSetBinding(),
    ),
    _page(
      name: AppRoutes.mechanicProfile,
      page: MechanicProfileView.new,
      binding: MechanicProfileBinding(),
    ),
    _page(name: AppRoutes.chat, page: ChatView.new, binding: ChatBinding()),
    _page(
      name: AppRoutes.editProfile,
      page: EditProfileView.new,
      binding: EditProfileBinding(),
    ),
    _page(
      name: AppRoutes.changePassword,
      page: ChangePasswordView.new,
      binding: ChangePasswordBinding(),
    ),
    _page(
      name: AppRoutes.notificationSettings,
      page: NotificationSettingsView.new,
      binding: NotificationSettingsBinding(),
    ),
    _page(
      name: AppRoutes.privacySettings,
      page: PrivacySettingsView.new,
      binding: PrivacySettingsBinding(),
    ),
    _page(name: AppRoutes.about, page: AboutView.new, binding: AboutBinding()),
    _page(
      name: AppRoutes.newRequestDetails,
      page: NewRequestDetailsView.new,
      binding: NewRequestBinding(),
    ),
    _page(
      name: AppRoutes.newRequestFiles,
      page: NewRequestFilesView.new,
      binding: NewRequestBinding(),
    ),
    _page(
      name: AppRoutes.newRequestReview,
      page: NewRequestReviewView.new,
      binding: NewRequestBinding(),
    ),
    _page(
      name: AppRoutes.requestDescription,
      page: RequestDescriptionView.new,
      binding: NewRequestBinding(),
    ),
    _page(
      name: AppRoutes.requestSubmitted,
      page: RequestSubmittedView.new,
      binding: RequestSubmittedBinding(),
      transition: Transition.fadeIn,
    ),
    _page(
      name: AppRoutes.main,
      page: MainShellView.new,
      binding: MainBinding(),
      transition: Transition.fadeIn,
    ),
    _page(
      name: AppRoutes.mechanicExperience,
      page: ExperienceView.new,
      binding: MechanicOnboardingBinding(),
    ),
    _page(
      name: AppRoutes.mechanicVehicles,
      page: VehiclesView.new,
      binding: MechanicOnboardingBinding(),
    ),
    _page(
      name: AppRoutes.mechanicExpertise,
      page: ExpertiseView.new,
      binding: MechanicOnboardingBinding(),
    ),
    _page(
      name: AppRoutes.mechanicVerification,
      page: VerificationView.new,
      binding: MechanicOnboardingBinding(),
    ),
    _page(
      name: AppRoutes.mechanicSubmitted,
      page: VerificationSubmittedView.new,
      binding: MechanicOnboardingBinding(),
    ),
    _page(
      name: AppRoutes.serviceRequestDetail,
      page: ServiceRequestDetailView.new,
      binding: ServiceRequestDetailBinding(),
    ),
    _page(
      name: AppRoutes.professionalProfile,
      page: ProfessionalProfileView.new,
      binding: ProfessionalProfileBinding(),
    ),
    _page(
      name: AppRoutes.verificationStatus,
      page: VerificationStatusView.new,
      binding: VerificationStatusBinding(),
    ),
    _page(
      name: AppRoutes.servicePricing,
      page: PricingView.new,
      binding: PricingBinding(),
    ),
    _page(
      name: AppRoutes.certifications,
      page: CertificationsView.new,
      binding: CertificationsBinding(),
    ),
    _page(
      name: AppRoutes.mechanicHome,
      page: MechanicShellView.new,
      binding: MechanicMainBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
