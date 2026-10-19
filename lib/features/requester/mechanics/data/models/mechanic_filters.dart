/// Kinds of help a mechanic can offer.
enum Specialty {
  engine,
  electrical,
  transmission,
  airConditioning,
  bodywork,
  diagnostics,
  diesel,
  heavyMachinery,
}

enum ExperienceRange {
  any,
  oneToFive,
  fiveToTen,
  tenPlus;

  /// Whether [years] of experience falls in this range.
  bool contains(int years) => switch (this) {
    ExperienceRange.any => true,
    ExperienceRange.oneToFive => years >= 1 && years <= 5,
    ExperienceRange.fiveToTen => years > 5 && years <= 10,
    ExperienceRange.tenPlus => years > 10,
  };
}

enum PriceRange {
  any,
  under100,
  from100to150,
  from150to200,
  over200;

  /// Whether a starting [price] in dollars falls in this range.
  bool contains(int price) => switch (this) {
    PriceRange.any => true,
    PriceRange.under100 => price < 100,
    PriceRange.from100to150 => price >= 100 && price <= 150,
    PriceRange.from150to200 => price > 150 && price <= 200,
    PriceRange.over200 => price > 200,
  };
}

/// Criteria for narrowing the mechanic list.
class MechanicFilters {
  const MechanicFilters({
    this.specialties = const {},
    this.nearMe = false,
    this.experience = ExperienceRange.any,
    this.price = PriceRange.any,
    this.verifiedOnly = false,
  });

  final Set<Specialty> specialties;
  final bool nearMe;
  final ExperienceRange experience;
  final PriceRange price;
  final bool verifiedOnly;

  bool get hasSpecialty => specialties.isNotEmpty;
  bool get hasExperience => experience != ExperienceRange.any;
  bool get hasPrice => price != PriceRange.any;

  MechanicFilters copyWith({
    Set<Specialty>? specialties,
    bool? nearMe,
    ExperienceRange? experience,
    PriceRange? price,
    bool? verifiedOnly,
  }) {
    return MechanicFilters(
      specialties: specialties ?? this.specialties,
      nearMe: nearMe ?? this.nearMe,
      experience: experience ?? this.experience,
      price: price ?? this.price,
      verifiedOnly: verifiedOnly ?? this.verifiedOnly,
    );
  }
}
