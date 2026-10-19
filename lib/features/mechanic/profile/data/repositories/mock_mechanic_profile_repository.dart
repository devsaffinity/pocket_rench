import 'package:pocketwrench/features/mechanic/profile/data/models/certification.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/pricing.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/professional_profile.dart';
import 'package:pocketwrench/features/mechanic/profile/data/models/verification.dart';
import 'package:pocketwrench/features/mechanic/profile/data/repositories/mechanic_profile_repository.dart';

/// Fixed sample data matching the design. Changes last until restart.
class MockMechanicProfileRepository implements MechanicProfileRepository {
  /// [verificationStatus] lets tests and previews show the pending screen.
  MockMechanicProfileRepository({
    this.verificationStatus = VerificationStatus.verified,
  });

  final VerificationStatus verificationStatus;

  static const Duration _latency = Duration(milliseconds: 400);

  PricingPlan _pricing = const PricingPlan(
    minimumCharge: 75,
    tiers: [
      PricingTier(
        id: 'standard',
        name: 'Standard Question',
        price: 100,
        description: 'Basic diagnostic question or advice',
      ),
      PricingTier(
        id: 'urgent',
        name: 'Urgent Question',
        price: 150,
        description: 'Priority response within 1 hour',
      ),
      PricingTier(
        id: 'video',
        name: 'Video Consultation',
        price: 200,
        description: '30-minute live video call',
      ),
      PricingTier(
        id: 'on-site',
        name: 'On-Site Visit',
        price: 350,
        description: 'In-person inspection at your location',
        isEnabled: false,
      ),
    ],
  );

  final List<Certification> _certifications = [
    Certification(
      id: 'ase',
      name: 'ASE Master Technician',
      status: CertificationStatus.verified,
      date: DateTime(2027, 12),
    ),
    Certification(
      id: 'epa',
      name: 'EPA Section 608',
      status: CertificationStatus.verified,
      date: DateTime(2028, 3),
    ),
    Certification(
      id: 'state',
      name: 'State License #48291',
      status: CertificationStatus.pending,
      date: DateTime(2026, 8),
    ),
  ];

  int _nextCertification = 0;

  @override
  Future<ProfessionalProfile> loadProfessionalProfile() async {
    await Future<void>.delayed(_latency);
    return const ProfessionalProfile(
      role: 'Automotive Mechanic',
      city: 'Dallas, TX',
      workshop: 'Anderson Auto Care',
      yearsExperience: 12,
      bio:
          'Experienced automotive technician specializing in diagnostics and '
          'electrical systems.',
      brands: ['Ford', 'Toyota', 'Chevrolet'],
      trade: 'Automotive Repair',
      primarySpecialty: 'Diagnostics',
      secondarySpecialty: 'Electrical',
      skills: ['OBD Diagnostics', 'Electrical Systems', 'Engine Diagnostics'],
    );
  }

  @override
  Future<Verification> loadVerification() async {
    await Future<void>.delayed(_latency);
    return Verification(
      status: verificationStatus,
      documents: const ['Certification', 'Trade License', 'Workshop ID'],
    );
  }

  @override
  Future<PricingPlan> loadPricing() async {
    await Future<void>.delayed(_latency);
    return _pricing;
  }

  @override
  Future<void> savePricing(PricingPlan plan) async {
    await Future<void>.delayed(_latency);
    _pricing = plan;
  }

  @override
  Future<List<Certification>> loadCertifications() async {
    await Future<void>.delayed(_latency);
    return List.unmodifiable(_certifications);
  }

  @override
  Future<Certification> submitCertification(String name) async {
    await Future<void>.delayed(_latency);
    final certification = Certification(
      id: 'submitted-${_nextCertification++}',
      name: name,
      status: CertificationStatus.pending,
      date: DateTime.now(),
    );
    _certifications.add(certification);
    return certification;
  }

  @override
  Future<void> removeCertification(String id) async {
    await Future<void>.delayed(_latency);
    _certifications.removeWhere((c) => c.id == id);
  }
}
