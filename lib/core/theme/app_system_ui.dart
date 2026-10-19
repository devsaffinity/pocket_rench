import 'package:flutter/services.dart';
import 'package:pocketwrench/core/constants/app_colors.dart';

/// Status/navigation bar styles. Wrap a screen in `AnnotatedRegion` with one of
/// these to match the design for that screen.
abstract final class AppSystemUi {
  /// Light icons over the app's dark background.
  static const SystemUiOverlayStyle lightIcons = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.background,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: AppColors.background,
    // Without this, Android tints the 3-button bar with its own scrim.
    systemNavigationBarContrastEnforced: false,
  );

  /// For screens that end in the bottom navigation bar: the system navigation
  /// area takes the bar's color, so the two read as one surface.
  static const SystemUiOverlayStyle lightIconsOnSurface = SystemUiOverlayStyle(
    statusBarColor: AppColors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.surface,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: AppColors.surface,
    systemNavigationBarContrastEnforced: false,
  );
}
