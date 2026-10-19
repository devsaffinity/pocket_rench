import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_filters.dart';

class Mechanic {
  const Mechanic({
    required this.id,
    required this.name,
    required this.avatar,
    required this.specialty,
    required this.yearsExperience,
    required this.city,
    required this.tags,
    required this.startingPrice,
    this.specialties = const [],
    this.isVerified = true,
  });

  final String id;
  final String name;

  /// Asset path or network URL.
  final String avatar;

  /// Headline, for example "Engine Specialist".
  final String specialty;
  final int yearsExperience;
  final String city;

  /// Skill chips shown on cards.
  final List<String> tags;

  /// Lowest service price in dollars.
  final int startingPrice;

  /// Categories used by the specialty filter.
  final List<Specialty> specialties;
  final bool isVerified;

  String get summary => '$specialty · $yearsExperience years · $city';
}
