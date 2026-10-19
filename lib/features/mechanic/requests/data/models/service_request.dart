import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';

/// Where a request stands for the mechanic.
enum ServiceStatus {
  /// Waiting for the mechanic to accept or decline.
  pending,

  /// Accepted; the mechanic and the requester are talking.
  active,
  resolved,
}

/// How the mechanic sees the request's urgency.
enum RequestPriority { normal, important, urgent }

/// A help request as seen by the mechanic it was sent to.
class ServiceRequest {
  const ServiceRequest({
    required this.id,
    required this.request,
    required this.requesterName,
    required this.requesterCity,
    required this.priority,
    required this.status,
    this.lastMessage,
  });

  final String id;
  final HelpRequest request;
  final String requesterName;
  final String requesterCity;
  final RequestPriority priority;
  final ServiceStatus status;

  /// The latest chat message from the requester, once a conversation exists.
  final String? lastMessage;

  String get title => request.title;

  /// Stable id of the requester, such as "james-wilson"; also the id of their
  /// conversation with the mechanic.
  String get requesterId =>
      requesterName.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '-');

  /// First letters of the requester's first two names, upper-cased.
  String get requesterInitials {
    final words = requesterName.trim().split(RegExp(r'\s+'));
    return words.where((w) => w.isNotEmpty).take(2).map((w) => w[0]).join();
  }

  ServiceRequest copyWith({ServiceStatus? status}) {
    return ServiceRequest(
      id: id,
      request: request,
      requesterName: requesterName,
      requesterCity: requesterCity,
      priority: priority,
      status: status ?? this.status,
      lastMessage: lastMessage,
    );
  }
}
