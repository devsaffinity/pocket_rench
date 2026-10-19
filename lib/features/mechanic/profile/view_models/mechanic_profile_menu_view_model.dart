import 'package:get/get.dart';
import 'package:pocketwrench/core/constants/app_icons.dart';
import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/core/routes/app_routes.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_menu.dart';
import 'package:pocketwrench/features/shared/profile/view_models/profile_view_model.dart';

/// The mechanic's Profile tab: the shared account settings plus the
/// professional ones (profile, verification, pricing, certifications).
class MechanicProfileMenuViewModel extends ProfileViewModel {
  MechanicProfileMenuViewModel(
    super.repository,
    super.authRepository, {
    required super.onBack,
    required super.onAccountChanged,
  });

  @override
  ProfileAudience get audience => ProfileAudience.mechanic;

  @override
  List<ProfileMenuSection> get menu => [
    ...accountSections,
    ProfileMenuSection(
      label: AppStrings.profileSectionProfessional,
      items: [
        ProfileMenuItem(
          iconPath: AppIcons.wrench,
          title: AppStrings.profileProfessionalProfile,
          onTap: onProfessionalProfile,
          isCompact: true,
        ),
        ProfileMenuItem(
          iconPath: AppIcons.check,
          title: AppStrings.profileVerification,
          onTap: onVerification,
          isCompact: true,
          showsVerifiedBadge: true,
        ),
        ProfileMenuItem(
          iconPath: AppIcons.dollar,
          title: AppStrings.profileServicePricing,
          onTap: onServicePricing,
          isCompact: true,
        ),
      ],
    ),
    ...generalSections,
  ];

  @override
  List<ProfileMenuSection> get extraSections => [
    ProfileMenuSection(
      label: AppStrings.profileSectionCertifications,
      items: [
        ProfileMenuItem(
          iconPath: AppIcons.award,
          title: AppStrings.profileManageCertifications,
          onTap: onCertifications,
        ),
      ],
    ),
  ];

  void onProfessionalProfile() =>
      Get.toNamed<void>(AppRoutes.professionalProfile);
  void onVerification() => Get.toNamed<void>(AppRoutes.verificationStatus);
  void onServicePricing() => Get.toNamed<void>(AppRoutes.servicePricing);
  void onCertifications() => Get.toNamed<void>(AppRoutes.certifications);
}
