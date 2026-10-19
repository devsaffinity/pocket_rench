import 'package:pocketwrench/features/mechanic/home/data/models/mechanic_home_data.dart';

/// What the signed-in mechanic sees on their home screen, apart from their
/// requests (see `ServiceRequestRepository`).
abstract class MechanicHomeRepository {
  Future<MechanicHomeData> loadHome();
}
