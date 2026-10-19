import 'package:flutter/widgets.dart';

abstract final class AppHelpers {
  /// Dismisses the keyboard.
  static void unfocus() => FocusManager.instance.primaryFocus?.unfocus();

  /// Disposes [notifiers] once the current frame has finished.
  ///
  /// A ViewModel is closed when its route is disposed, but the leaving screen
  /// can still rebuild in that same frame (for example when the keyboard
  /// dismisses), and a [TextField] must not see a disposed controller or
  /// [FocusNode]. Call this from `onClose` instead of disposing directly.
  static void disposeAfterFrame(Iterable<ChangeNotifier> notifiers) {
    final pending = List<ChangeNotifier>.of(notifiers);
    WidgetsBinding.instance
      ..addPostFrameCallback((_) {
        for (final notifier in pending) {
          notifier.dispose();
        }
      })
      ..scheduleFrame();
  }
}
