/// A vehicle model and its engine, for example F-150 with "Ecoboost V6".
class VehicleModel {
  const VehicleModel(this.name, {this.engine});

  final String name;
  final String? engine;
}

/// Choices offered while describing a problem.
abstract final class VehicleCatalog {
  static const List<String> categories = [
    'Engine',
    'Transmission',
    'Brakes',
    'Electrical',
    'A/C',
    'Suspension',
    'Bodywork',
    'Diagnostics',
    'Other',
  ];

  static const Map<String, List<VehicleModel>> modelsByMake = {
    'Ford': [
      VehicleModel('F-150', engine: 'Ecoboost V6'),
      VehicleModel('Mustang', engine: '5.0L V8'),
      VehicleModel('Explorer', engine: '2.3L Ecoboost I4'),
    ],
    'Toyota': [
      VehicleModel('Camry', engine: '2.5L I4'),
      VehicleModel('Corolla', engine: '2.0L I4'),
      VehicleModel('Tacoma', engine: '3.5L V6'),
    ],
    'Honda': [
      VehicleModel('Civic', engine: '2.0L I4'),
      VehicleModel('Accord', engine: '1.5L Turbo I4'),
      VehicleModel('CR-V', engine: '1.5L Turbo I4'),
    ],
    'Jeep': [
      VehicleModel('Wrangler', engine: '3.6L Pentastar V6'),
      VehicleModel('Grand Cherokee', engine: '3.6L Pentastar V6'),
    ],
    'Chevrolet': [
      VehicleModel('Silverado', engine: '5.3L V8'),
      VehicleModel('Malibu', engine: '1.5L Turbo I4'),
    ],
    'BMW': [
      VehicleModel('3 Series', engine: '2.0L Turbo I4'),
      VehicleModel('X5', engine: '3.0L Turbo I6'),
    ],
  };

  static List<String> get makes => modelsByMake.keys.toList();

  /// Model years, newest first.
  static List<int> get years => [for (var y = 2025; y >= 1995; y--) y];
}
