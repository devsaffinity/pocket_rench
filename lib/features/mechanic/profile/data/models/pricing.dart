/// One service the mechanic offers, with its price.
class PricingTier {
  const PricingTier({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.isEnabled = true,
  });

  final String id;
  final String name;

  /// In dollars.
  final int price;
  final String description;
  final bool isEnabled;

  PricingTier copyWith({bool? isEnabled}) => PricingTier(
    id: id,
    name: name,
    price: price,
    description: description,
    isEnabled: isEnabled ?? this.isEnabled,
  );
}

/// The mechanic's tiers and the least they charge for a session.
class PricingPlan {
  const PricingPlan({required this.tiers, required this.minimumCharge});

  final List<PricingTier> tiers;

  /// In dollars.
  final int minimumCharge;
}
