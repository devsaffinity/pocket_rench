import 'package:flutter/material.dart';

/// Every color used in the app, named by role rather than by hex value.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFFEAF205);
  static const Color onPrimary = Color(0xFF000000);
  static const Color logoAccent = Color(0xFFDAFF00);
  static const Color accent = Color(0xFF8005F2);
  static const Color accentSoft = Color(0xFFEE98FF);

  // Surfaces
  static const Color background = Color(0xFF020000);
  static const Color surface = Color(0xFF17181C);
  static const Color surfaceIcon = Color(0xFF2A2A2D);
  static const Color border = Color(0xFF333333);

  // Text
  static const Color textPrimary = Color(0xFFF2F2F2);
  static const Color textSecondary = Color(0xFFD9D9D9);
  static const Color textMuted = Color(0xFFE5E5E5);
  static const Color textHint = Color(0xFFBFBFBF);
  static const Color white = Color(0xFFFFFFFF);

  // Controls
  static const Color iconMuted = Color(0xFF94A3B8);
  static const Color checkbox = Color(0xFF7D5EEF);

  // Home
  static const Color textSubtle = Color(0xFFA1A1AA);
  static const Color onLime = Color(0xFF111111);
  static const Color requestIconBackground = Color(0xFF2A2A18);
  static const Color urgent = Color(0xFFFF383C);

  // Messages
  static const Color bubbleIncoming = Color(0xFF2A2A2A);
  static const Color verifiedTagBackground = Color(0xFF021508);
  static const Color verifiedTagText = Color(0xFF00FF66);
  static const Color recording = Color(0xFFFF453A);
  static const Color emptyIconBackground = Color(0xFF1D2000);
  static const Color imageDim = Color(0x40000000);
  static const Color dimScrim = Color(0xB3000000);

  // Requests
  static const Color categoryTag = Color(0xFFA020F0);

  // Provisional: not shown in any design yet.
  static const Color chevron = Color(0xFF666666);
  static const Color verifiedChipBackground = Color(0xFF1F362B);
  static const Color verifiedChipText = Color(0xFF4ADE80);
  static const Color pendingChipBackground = Color(0xFF39311D);
  static const Color pendingChipText = Color(0xFFFBBF24);
  static const Color verifiedCircle = Color(0xFF061007);
  static const Color pendingCircle = Color(0xFF170C00);
  static const Color pendingAccent = Color(0xFFFF9500);
  static const Color proDivider = Color(0xFF2A2A2A);
  static const Color uploadTileIcon = Color(0xFF343B18);
  static const Color manualTileIcon = Color(0xFF232427);
  static const Color resolvedTagBackground = Color(0xFF143525);
  static const Color urgentChipBackground = Color(0xFF220706);
  static const Color lastMessageBackground = Color(0xFF111111);
  static const Color pendingTag = Color(0xFF1B0130);
  static const Color rowDivider = Color(0xFF262629);
  static const Color placeholder = Color(0xFF666666);

  static const Color error = Color(0xFFFF4D4F);
  static const Color success = Color(0xFF34C759);

  /// Dims and blurs the screen behind a bottom sheet.
  static const Color scrim = Color(0x66000000);

  /// 20% black laid over the welcome hero photo.
  static const Color heroScrim = Color(0x33000000);

  static const Color transparent = Color(0x00000000);
}
