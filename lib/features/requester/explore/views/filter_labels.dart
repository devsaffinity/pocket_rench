import 'package:pocketwrench/core/constants/app_strings.dart';
import 'package:pocketwrench/features/requester/mechanics/data/models/mechanic_filters.dart';

/// Display text for filter options.
extension SpecialtyLabel on Specialty {
  String get label => switch (this) {
    Specialty.engine => AppStrings.specEngine,
    Specialty.electrical => AppStrings.specElectrical,
    Specialty.transmission => AppStrings.specTransmission,
    Specialty.airConditioning => AppStrings.specAirConditioning,
    Specialty.bodywork => AppStrings.specBodywork,
    Specialty.diagnostics => AppStrings.specDiagnostics,
    Specialty.diesel => AppStrings.specDiesel,
    Specialty.heavyMachinery => AppStrings.specHeavyMachinery,
  };
}

extension ExperienceRangeLabel on ExperienceRange {
  String get label => switch (this) {
    ExperienceRange.any => AppStrings.experienceAny,
    ExperienceRange.oneToFive => AppStrings.experience1to5,
    ExperienceRange.fiveToTen => AppStrings.experience5to10,
    ExperienceRange.tenPlus => AppStrings.experience10plus,
  };
}

extension PriceRangeLabel on PriceRange {
  String get label => switch (this) {
    PriceRange.any => AppStrings.priceAny,
    PriceRange.under100 => AppStrings.priceUnder100,
    PriceRange.from100to150 => AppStrings.price100to150,
    PriceRange.from150to200 => AppStrings.price150to200,
    PriceRange.over200 => AppStrings.price200plus,
  };
}
