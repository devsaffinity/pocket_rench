import 'package:pocketwrench/features/shared/requests/data/models/help_request.dart';
import 'package:pocketwrench/features/shared/requests/data/models/request_attachment.dart';

/// A help request being filled in across the three steps.
class RequestDraft {
  const RequestDraft({
    this.title = '',
    this.category,
    this.make,
    this.model,
    this.year,
    this.engine,
    this.urgency = RequestUrgency.normal,
    this.description = '',
    this.attachments = const [],
  });

  final String title;
  final String? category;
  final String? make;
  final String? model;
  final int? year;
  final String? engine;
  final RequestUrgency urgency;
  final String description;
  final List<RequestAttachment> attachments;

  /// Whether the required details are filled in.
  bool get isComplete =>
      title.trim().isNotEmpty &&
      category != null &&
      make != null &&
      model != null &&
      year != null;

  RequestDraft copyWith({
    String? title,
    String? category,
    String? make,
    String? model,
    int? year,
    String? engine,
    bool clearModel = false,
    RequestUrgency? urgency,
    String? description,
    List<RequestAttachment>? attachments,
  }) {
    return RequestDraft(
      title: title ?? this.title,
      category: category ?? this.category,
      make: make ?? this.make,
      model: clearModel ? null : model ?? this.model,
      year: year ?? this.year,
      engine: clearModel ? null : engine ?? this.engine,
      urgency: urgency ?? this.urgency,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
    );
  }

  /// Builds the request that [id] identifies once the draft is sent.
  HelpRequest toRequest(String id) => HelpRequest(
    id: id,
    title: title.trim(),
    category: category!,
    make: make!,
    model: model!,
    year: year!,
    engine: engine,
    urgency: urgency,
    description: description.trim(),
    attachments: attachments,
  );
}
