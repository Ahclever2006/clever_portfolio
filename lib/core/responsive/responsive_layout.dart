import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:flutter/widgets.dart';

/// Picks a subtree by breakpoint; missing tiers fall back downward.
class ResponsiveLayout extends StatelessWidget {
  /// Creates a [ResponsiveLayout]; [mobile] is the required base subtree.
  const ResponsiveLayout({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.wide,
    super.key,
  });

  /// Base subtree.
  final Widget mobile;

  /// Tablet subtree.
  final Widget? tablet;

  /// Desktop subtree.
  final Widget? desktop;

  /// Wide subtree.
  final Widget? wide;

  @override
  Widget build(BuildContext context) {
    return Responsive<Widget>(
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      wide: wide,
    ).resolve(context.bp);
  }
}
