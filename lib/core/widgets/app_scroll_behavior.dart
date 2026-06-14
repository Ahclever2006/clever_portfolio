import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Scroll behavior that lets pointers **drag** scrollables (PageView, lists) —
/// on web/desktop Flutter disables mouse drag by default, which breaks
/// swipe-by-mouse. Applied app-wide via `MaterialApp.scrollBehavior`.
class AppScrollBehavior extends MaterialScrollBehavior {
  /// Creates an [AppScrollBehavior].
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
