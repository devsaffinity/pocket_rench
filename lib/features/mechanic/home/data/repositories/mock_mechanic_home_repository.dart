import 'package:pocketwrench/features/mechanic/home/data/models/mechanic_home_data.dart';
import 'package:pocketwrench/features/mechanic/home/data/repositories/mechanic_home_repository.dart';

/// Fixed sample numbers matching the design.
class MockMechanicHomeRepository implements MechanicHomeRepository {
  static const Duration _latency = Duration(milliseconds: 500);

  @override
  Future<MechanicHomeData> loadHome() async {
    await Future<void>.delayed(_latency);
    return const MechanicHomeData(
      stats: MechanicStats(requestsHelped: 142, helpfulRating: 4.9),
    );
  }
}
