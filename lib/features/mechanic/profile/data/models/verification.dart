/// Where the review of the mechanic's documents stands.
enum VerificationStatus { verified, pending }

class Verification {
  const Verification({required this.status, required this.documents});

  final VerificationStatus status;

  /// Names of the documents under review, for example "Trade License".
  final List<String> documents;
}
