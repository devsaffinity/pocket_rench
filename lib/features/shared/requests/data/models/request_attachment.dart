enum AttachmentKind { image, video, document }

/// A file added to a help request.
class RequestAttachment {
  const RequestAttachment({
    required this.id,
    required this.name,
    required this.kind,
    this.sizeLabel = '',
    this.previewUrl,
    this.progress = 1,
  });

  final String id;
  final String name;
  final AttachmentKind kind;

  /// For example "1.2 MB".
  final String sizeLabel;

  /// Asset path or network URL shown as a thumbnail (images and videos).
  final String? previewUrl;

  /// Upload progress from 0 to 1. 1 means finished.
  final double progress;

  bool get isUploading => progress < 1;

  RequestAttachment copyWith({double? progress}) => RequestAttachment(
    id: id,
    name: name,
    kind: kind,
    sizeLabel: sizeLabel,
    previewUrl: previewUrl,
    progress: progress ?? this.progress,
  );
}
