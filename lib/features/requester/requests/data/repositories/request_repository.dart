import 'package:pocketwrench/features/requester/requests/data/models/request_draft.dart';
import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';

/// The signed-in person's help requests.
abstract class RequestRepository {
  /// Newest first.
  Future<List<HelpRequest>> loadRequests();

  /// Sends [draft] and returns the stored request.
  Future<HelpRequest> submit(RequestDraft draft);
}
