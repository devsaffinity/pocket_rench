import 'package:pocketwrench/features/mechanic/onboarding/data/models/uploaded_document.dart';

/// Everything a mechanic entered during onboarding.
class MechanicOnboardingDraft {
  const MechanicOnboardingDraft({
    required this.trade,
    required this.yearsRange,
    required this.city,
    required this.specialties,
    required this.brands,
    required this.certifications,
    required this.skills,
    required this.standardPrice,
    required this.urgentPrice,
    required this.livePrice,
    required this.documents,
  });

  final String trade;
  final String yearsRange;
  final String city;
  final Set<String> specialties;
  final Set<String> brands;
  final Set<String> certifications;
  final Set<String> skills;
  final int standardPrice;
  final int urgentPrice;
  final int livePrice;
  final List<UploadedDocument> documents;
}
