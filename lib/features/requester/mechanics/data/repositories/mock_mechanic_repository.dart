import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_filters.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_profile.dart';
import 'package:pocketwrench/features/requester/mechanics/data/repositories/mechanic_repository.dart';

/// Fixed sample data matching the design.
class MockMechanicRepository implements MechanicRepository {
  static const Duration _latency = Duration(milliseconds: 400);

  static const List<Mechanic> _suggested = [
    Mechanic(
      id: 'carlos-rivera',
      name: 'Carlos Rivera',
      avatar: 'https://randomuser.me/api/portraits/men/75.jpg',
      specialty: 'Engine Specialist',
      yearsExperience: 15,
      city: 'Dallas, TX',
      tags: ['Engine', 'Transmission'],
      startingPrice: 120,
      specialties: [Specialty.engine, Specialty.transmission],
    ),
    Mechanic(
      id: 'aisha-patel',
      name: 'Aisha Patel',
      avatar: 'https://randomuser.me/api/portraits/women/68.jpg',
      specialty: 'Bodywork Specialist',
      yearsExperience: 12,
      city: 'Los Angeles, CA',
      tags: ['Body', 'Aerodynamics'],
      startingPrice: 110,
      specialties: [Specialty.bodywork],
    ),
    Mechanic(
      id: 'mohamed-el-sayed',
      name: 'Mohamed El-Sayed',
      avatar: 'https://randomuser.me/api/portraits/men/45.jpg',
      specialty: 'Automotive Electrician',
      yearsExperience: 8,
      city: 'Detroit, MI',
      tags: ['Wiring', 'Electronics'],
      startingPrice: 130,
      specialties: [Specialty.electrical],
    ),
    Mechanic(
      id: 'jessica-yang',
      name: 'Jessica Yang',
      avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
      specialty: 'Chassis Specialist',
      yearsExperience: 10,
      city: 'San Francisco, CA',
      tags: ['Chassis', 'Suspension'],
      startingPrice: 140,
    ),
  ];

  static const Mechanic _kingTom = Mechanic(
    id: 'king-tom',
    name: 'King Tom',
    avatar: 'https://randomuser.me/api/portraits/men/22.jpg',
    specialty: 'Automotive Mechanic',
    yearsExperience: 9,
    city: 'Dallas, TX',
    tags: ['Diagnostics', 'Electrical'],
    startingPrice: 100,
    specialties: [Specialty.diagnostics, Specialty.electrical],
  );

  @override
  Future<List<Mechanic>> searchMechanics({
    String query = '',
    MechanicFilters filters = const MechanicFilters(),
  }) async {
    await Future<void>.delayed(_latency);
    final needle = query.trim().toLowerCase();

    return _suggested.where((mechanic) {
      if (needle.isNotEmpty) {
        final haystack = [
          mechanic.name,
          mechanic.specialty,
          mechanic.city,
          ...mechanic.tags,
        ].join(' ').toLowerCase();
        if (!haystack.contains(needle)) return false;
      }
      if (filters.hasSpecialty &&
          !mechanic.specialties.any(filters.specialties.contains)) {
        return false;
      }
      if (filters.verifiedOnly && !mechanic.isVerified) return false;
      if (!filters.experience.contains(mechanic.yearsExperience)) return false;
      if (!filters.price.contains(mechanic.startingPrice)) return false;
      // "Near me" needs the device location, which the mock does not have.
      return true;
    }).toList();
  }

  @override
  Future<MechanicProfile> loadProfile(String mechanicId) async {
    await Future<void>.delayed(_latency);
    final mechanic = [
      ..._suggested,
      _kingTom,
    ].firstWhere((m) => m.id == mechanicId, orElse: () => _kingTom);

    return MechanicProfile(
      mechanic: mechanic,
      role: mechanic.specialty,
      specialties: mechanic.tags,
      brands: [
        BrandExpertise(
          brand: 'Ford',
          focus: '${mechanic.tags.first} systems · ${mechanic.tags.last}',
        ),
        BrandExpertise(
          brand: 'Toyota',
          focus: '${mechanic.tags.last} · ${mechanic.tags.first}',
        ),
      ],
      about:
          'Experienced automotive mechanic specializing in vehicle '
          'diagnostics and electrical systems. Dedicated to offering '
          'precision support and reliable repairs.',
      pricing: const [
        ServiceTier(
          title: 'Standard Question',
          description: 'Basic diagnostic question or advice',
          price: 100,
        ),
        ServiceTier(
          title: 'Urgent Question',
          description: 'Priority response within 1 hour',
          price: 150,
        ),
        ServiceTier(
          title: 'Video Consultation',
          description: '30-min live video call',
          price: 200,
        ),
      ],
      skills: const [
        'OBD Diagnostics',
        'Electrical Systems',
        'Engine Diagnostics',
      ],
      requestsHelped: 24,
      helpfulRatings: 18,
    );
  }
}
