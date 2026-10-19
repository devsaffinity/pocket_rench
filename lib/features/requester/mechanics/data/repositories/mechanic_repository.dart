import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_filters.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_profile.dart';

/// Mechanic directory.
abstract class MechanicRepository {
  Future<List<Mechanic>> searchMechanics({
    String query = '',
    MechanicFilters filters = const MechanicFilters(),
  });

  Future<MechanicProfile> loadProfile(String mechanicId);
}
