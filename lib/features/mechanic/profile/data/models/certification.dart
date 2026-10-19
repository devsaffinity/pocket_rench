enum CertificationStatus { verified, pending }

class Certification {
  const Certification({
    required this.id,
    required this.name,
    required this.status,
    required this.date,
  });

  final String id;
  final String name;
  final CertificationStatus status;

  /// When it expires (verified) or was submitted (pending).
  final DateTime date;
}
