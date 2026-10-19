/// Headline numbers on the mechanic's home.
class MechanicStats {
  const MechanicStats({
    required this.requestsHelped,
    required this.helpfulRating,
  });

  final int requestsHelped;

  /// Out of 5.
  final double helpfulRating;
}

class MechanicHomeData {
  const MechanicHomeData({required this.stats});

  final MechanicStats stats;
}
