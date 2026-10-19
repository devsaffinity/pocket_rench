import 'package:pocketwrench/features/mechanic/profile/data/models/certification.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/pricing.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/professional_profile.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/verification.dart';

/// The mechanic's professional settings.
abstract class MechanicProfileRepository {
  Future<ProfessionalProfile> loadProfessionalProfile();

  Future<Verification> loadVerification();

  Future<PricingPlan> loadPricing();
  Future<void> savePricing(PricingPlan plan);

  /// Newest last.
  Future<List<Certification>> loadCertifications();

  /// Sends a certification for review; it starts as pending.
  Future<Certification> submitCertification(String name);

  Future<void> removeCertification(String id);
}
