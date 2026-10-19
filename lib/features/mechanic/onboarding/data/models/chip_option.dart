/// A selectable label with an optional trailing emoji (a flag or an icon).
class ChipOption {
  const ChipOption(this.label, {this.emoji});

  final String label;
  final String? emoji;

  /// What the chip shows.
  String get display => emoji == null ? label : '$label $emoji';
}
