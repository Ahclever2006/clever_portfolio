/// Responsive breakpoints (plan.md §3.3 / §8).
enum Breakpoint {
  /// `< 600`
  mobile,

  /// `600–1024`
  tablet,

  /// `1024–1440`
  desktop,

  /// `> 1440`
  wide,
}

/// Breakpoint boundaries + width → [Breakpoint] resolution.
abstract final class AppBreakpoints {
  const AppBreakpoints._();

  /// Upper bound (exclusive) of [Breakpoint.mobile].
  static const double mobileMax = 600;

  /// Upper bound (exclusive) of [Breakpoint.tablet].
  static const double tabletMax = 1024;

  /// Lower bound of [Breakpoint.wide].
  static const double wideMin = 1440;

  /// Maps a logical [width] to its [Breakpoint].
  static Breakpoint of(double width) {
    if (width < mobileMax) return Breakpoint.mobile;
    if (width < tabletMax) return Breakpoint.tablet;
    if (width < wideMin) return Breakpoint.desktop;
    return Breakpoint.wide;
  }
}
