import 'package:flutter/material.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';
import 'package:pocketwrench/core/constants/app_sizes.dart';

/// Fades and slides its child up on first build. Use increasing [delay]s for a
/// staggered entrance.
class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    required this.child,
    super.key,
    this.delay = Duration.zero,
    this.duration = AppDurations.entry,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final total = delay + duration;
    final curve = Interval(
      delay.inMilliseconds / total.inMilliseconds,
      1,
      curve: AppDurations.standardCurve,
    );
    final offset = AppSizes.entryOffset;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: total,
      curve: curve,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * offset),
          child: child,
        ),
      ),
    );
  }
}
