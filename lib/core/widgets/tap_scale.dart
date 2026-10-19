import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pocketwrench/core/constants/app_durations.dart';

/// Adds a scale-down and fade on press to any child.
///
/// Pass a null [onTap] to render the child without any interaction.
class TapScale extends StatefulWidget {
  const TapScale({
    required this.child,
    super.key,
    this.onTap,
    this.haptic = false,
  });

  final Widget child;
  final VoidCallback? onTap;

  /// Fires a light haptic on tap.
  final bool haptic;

  @override
  State<TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<TapScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  void _handleTap() {
    if (widget.haptic) HapticFeedback.lightImpact();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap == null) return widget.child;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: _handleTap,
      child: AnimatedScale(
        scale: _pressed ? AppDurations.tapScaleDown : 1,
        duration: AppDurations.tap,
        curve: AppDurations.standardCurve,
        child: AnimatedOpacity(
          opacity: _pressed ? AppDurations.tapOpacityDown : 1,
          duration: AppDurations.tap,
          child: widget.child,
        ),
      ),
    );
  }
}
