import 'package:flutter/foundation.dart';

/// Whose settings a screen is showing; a few labels and lists differ.
enum ProfileAudience { requester, mechanic }

/// One tappable card in the Profile menu.
class ProfileMenuItem {
  const ProfileMenuItem({
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.isCompact = false,
    this.showsVerifiedBadge = false,
  });

  final String iconPath;
  final String title;
  final VoidCallback onTap;

  /// A slightly shorter card, as drawn for the professional settings.
  final bool isCompact;

  /// Shows the verified badge after the title.
  final bool showsVerifiedBadge;
}

/// An uppercase label and the cards under it.
class ProfileMenuSection {
  const ProfileMenuSection({required this.label, required this.items});

  final String label;
  final List<ProfileMenuItem> items;
}
