import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';

class BrandExpertise {
  const BrandExpertise({required this.brand, required this.focus});

  final String brand;

  /// For example "Electrical systems · Diagnostics".
  final String focus;
}

class ServiceTier {
  const ServiceTier({
    required this.title,
    required this.description,
    required this.price,
  });

  final String title;
  final String description;

  /// Price in dollars.
  final int price;
}

/// Everything shown on a mechanic's profile.
class MechanicProfile {
  const MechanicProfile({
    required this.mechanic,
    required this.role,
    required this.specialties,
    required this.brands,
    required this.about,
    required this.pricing,
    required this.skills,
    required this.requestsHelped,
    required this.helpfulRatings,
  });

  final Mechanic mechanic;
  final String role;
  final List<String> specialties;
  final List<BrandExpertise> brands;
  final String about;
  final List<ServiceTier> pricing;
  final List<String> skills;
  final int requestsHelped;
  final int helpfulRatings;
}
