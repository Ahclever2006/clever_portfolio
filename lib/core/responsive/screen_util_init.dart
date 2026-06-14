import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The mandated "sizeHelper" boundary: initializes flutter_screenutil with the
/// desktop-first design size so `.w` / `.h` / `.sp` / `.r` resolve everywhere.
/// Wrap `MaterialApp` with this (plan.md §8).
class AppScreenUtilInit extends StatelessWidget {
  /// Creates an [AppScreenUtilInit] that builds [builder] once initialized.
  const AppScreenUtilInit({required this.builder, super.key});

  /// Builds the app subtree (typically `MaterialApp`).
  final Widget Function(BuildContext context, Widget? child) builder;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      builder: builder,
    );
  }
}
