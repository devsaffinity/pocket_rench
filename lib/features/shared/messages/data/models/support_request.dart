/// A support request a chat can be about: pinned at the top of the thread and
/// attachable when a requester contacts a mechanic.
class SupportRequest {
  const SupportRequest({
    required this.id,
    required this.title,
    required this.details,
  });

  final String id;
  final String title;

  /// For example "2019 Ford F-150 · Engine".
  final String details;
}
