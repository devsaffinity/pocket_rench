import 'package:flutter/animation.dart';

/// Animation durations, curves and tuning values.
abstract final class AppDurations {
  // Durations
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration tap = Duration(milliseconds: 120);
  static const Duration entry = Duration(milliseconds: 500);
  static const Duration entryStagger = Duration(milliseconds: 90);
  static const Duration pageTransition = Duration(milliseconds: 350);
  static const Duration logoFadeIn = Duration(milliseconds: 700);
  static const Duration splashHold = Duration(seconds: 2);

  // Curves
  static const Curve standardCurve = Curves.easeOutCubic;
  static const Curve pageCurve = Curves.easeInOut;

  // Tap feedback
  static const double tapScaleDown = 0.96;
  static const double tapOpacityDown = 0.85;
  static const double disabledOpacity = 0.5;
}
