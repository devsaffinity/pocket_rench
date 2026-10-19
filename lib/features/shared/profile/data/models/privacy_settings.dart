/// What mechanics may see about the person.
class PrivacySettings {
  const PrivacySettings({required this.cityLevelLocationOnly});

  /// Mechanics only ever see the city, never the exact location.
  final bool cityLevelLocationOnly;
}
