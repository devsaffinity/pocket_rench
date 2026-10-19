import 'package:flutter/painting.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';

/// Gradients used in the design.
abstract final class AppGradients {
  /// Yellow-green to purple, left to right.
  static const LinearGradient brand = LinearGradient(
    colors: [AppColors.logoAccent, AppColors.accent],
  );

  /// Fades a photo into the surface color on its left edge and dims the rest
  /// slightly, so the text beside it stays readable.
  static const LinearGradient imageEdgeFade = LinearGradient(
    colors: [AppColors.surface, AppColors.imageDim],
    stops: [0, 0.7],
  );
}
