/// A credential document the mechanic has uploaded.
class UploadedDocument {
  const UploadedDocument({
    required this.id,
    required this.name,
    required this.sizeLabel,
    required this.kindLabel,
  });

  final String id;
  final String name;
  final String sizeLabel;

  /// For example "PDF Document".
  final String kindLabel;
}
