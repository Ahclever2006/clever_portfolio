import 'package:flutter/widgets.dart';

/// Exposes the page's outer (vertical) [ScrollController] to descendants.
///
/// Widgets that want to react to page scroll — e.g. [ParallaxImage] — live deep
/// in the tree, often inside their own (horizontal) [Scrollable] such as a
/// `PageView`. `Scrollable.of(context)` would there resolve to that inner
/// scrollable, not the page scroll. This inherited widget lets the home page
/// hand the real page controller down explicitly.
class PageScroll extends InheritedWidget {
  /// Creates a [PageScroll] providing [controller] to [child]'s subtree.
  const PageScroll({required this.controller, required super.child, super.key});

  /// The outer, vertical scroll controller driving the long-scroll page.
  final ScrollController controller;

  /// The nearest page [ScrollController], or `null` outside a [PageScroll]
  /// (e.g. inside a dialog) — callers degrade to a static, non-parallax layout.
  static ScrollController? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PageScroll>()?.controller;

  @override
  bool updateShouldNotify(PageScroll oldWidget) =>
      controller != oldWidget.controller;
}
