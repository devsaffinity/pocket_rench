import 'package:pocketwrench/features/mechanic/requests/data/models/service_request.dart';

/// The requests sent to the signed-in mechanic.
abstract class ServiceRequestRepository {
  /// Newest first, across all statuses.
  Future<List<ServiceRequest>> loadRequests();

  Future<ServiceRequest> loadRequest(String id);

  /// Accepting makes a pending request active; declining removes it.
  Future<void> respond(String id, {required bool accept});
}
