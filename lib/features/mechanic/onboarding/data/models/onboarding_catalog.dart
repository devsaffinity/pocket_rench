import 'package:pocketwrench/features/mechanic/onboarding/data/models/chip_option.dart';

/// Choices offered during mechanic onboarding. Fixed sample data until the
/// backend provides them.
abstract final class OnboardingCatalog {
  static const List<String> trades = [
    'Automotive Technician',
    'Diesel Mechanic',
    'Body & Paint Specialist',
    'Auto Electrician',
    'Hybrid/EV Technician',
  ];

  static const List<String> yearsRanges = [
    '1-2 yrs',
    '3-5 yrs',
    '5-10 yrs',
    '10+ yrs',
  ];

  static const List<String> specialties = [
    'Engine',
    'Transmission',
    'Electrical',
    'Diagnostics',
    'Diesel',
    'Bodywork',
    'A/C Systems',
    'Heavy Machinery',
    'Brakes & Rotors',
    'Fuel Systems',
    'Exhaust',
    'Suspension',
    'Steering',
    'Cooling Systems',
    'Hybrid/EV',
  ];

  static const List<ChipOption> brands = [
    ChipOption('Toyota', emoji: '🇯🇵'),
    ChipOption('Ford', emoji: '🇺🇸'),
    ChipOption('Chevrolet', emoji: '🇺🇸'),
    ChipOption('Honda', emoji: '🇯🇵'),
    ChipOption('BMW', emoji: '🇩🇪'),
    ChipOption('Tesla', emoji: '⚡'),
  ];

  static const List<ChipOption> certifications = [
    ChipOption('ASE Certified', emoji: '🎖️'),
    ChipOption('Diesel Specialist', emoji: '🚛'),
    ChipOption('Hybrid/EV Safety', emoji: '🔋'),
    ChipOption('State Safety Inspector'),
    ChipOption('AC Delco Trained'),
    ChipOption('EPA 608'),
    ChipOption('Snap-on Diagnostics'),
    ChipOption('Toyota T-TEN'),
    ChipOption('Ford ASSET'),
  ];

  static const List<String> skills = [
    'OBD-II Diagnostics',
    'Brake Systems',
    'Fuel Injection Tuning',
    'Wheel Alignment',
    'Oscilloscope Analysis',
    'CAN-bus Debugging',
  ];

  /// Starting prices, in dollars, for each kind of service.
  static const int standardPrice = 100;
  static const int urgentPrice = 150;
  static const int livePrice = 200;
}
