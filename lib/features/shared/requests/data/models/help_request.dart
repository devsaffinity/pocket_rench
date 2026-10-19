import 'package:pocketwrench/features/shared/requests/data/models/request_attachment.dart';

enum RequestUrgency { low, normal, urgent }

enum RequestStatus { active, resolved }

/// A problem the person wants a mechanic's help with.
class HelpRequest {
  const HelpRequest({
    required this.id,
    required this.title,
    required this.category,
    required this.make,
    required this.model,
    required this.year,
    required this.urgency,
    required this.description,
    this.engine,
    this.attachments = const [],
    this.status = RequestStatus.active,
    this.postedLabel = 'now',
  });

  final String id;
  final String title;
  final String category;
  final String make;
  final String model;
  final int year;
  final RequestUrgency urgency;
  final String description;

  /// For example "Ecoboost V6".
  final String? engine;
  final List<RequestAttachment> attachments;
  final RequestStatus status;

  /// Relative time such as "2m ago".
  final String postedLabel;

  String get vehicle => '$year $make $model';

  /// "2019 Ford F-150 · Engine · 2m ago".
  String get summary => '$vehicle · $category · $postedLabel';

  /// "2019 Ford F-150 · Engine", used where the time is not needed.
  String get shortSummary => '$vehicle · $category';

  bool get isResolved => status == RequestStatus.resolved;
}
