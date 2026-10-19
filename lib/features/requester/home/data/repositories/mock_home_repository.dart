import 'package:pocketwrench/features/requester/home/data/models/home_data.dart';
import 'package:pocketwrench/features/requester/home/data/repositories/home_repository.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_filters.dart';

/// Fixed sample data matching the design.
class MockHomeRepository implements HomeRepository {
  static const String _carlosAvatar =
      'https://randomuser.me/api/portraits/men/75.jpg';
  static const String _aishaAvatar =
      'https://randomuser.me/api/portraits/women/68.jpg';

  static const Duration _latency = Duration(milliseconds: 500);

  @override
  Future<HomeData> loadHome() async {
    await Future<void>.delayed(_latency);
    return const HomeData(
      mechanics: [
        Mechanic(
          id: 'carlos-rivera',
          name: 'Carlos Rivera',
          avatar: _carlosAvatar,
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
          avatar: _aishaAvatar,
          specialty: 'Bodywork Specialist',
          yearsExperience: 12,
          city: 'Los Angeles, CA',
          tags: ['Body', 'Aerodynamics'],
          startingPrice: 110,
          specialties: [Specialty.bodywork],
        ),
      ],
    );
  }
}
