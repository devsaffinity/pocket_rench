import 'package:pocketwrench/features/requester/onboarding/data/repositories/profile_repository.dart';

/// In-memory stand-in with a fixed city list.
class MockProfileRepository implements ProfileRepository {
  static const Duration _latency = Duration(milliseconds: 600);

  @override
  Future<List<String>> loadCities() async => const [
    'Dallas, TX',
    'Houston, TX',
    'Austin, TX',
    'Los Angeles, CA',
    'San Diego, CA',
    'Phoenix, AZ',
    'Chicago, IL',
    'New York, NY',
  ];

  @override
  Future<void> saveProfile({String? photoPath, String? city}) =>
      Future<void>.delayed(_latency);
}
