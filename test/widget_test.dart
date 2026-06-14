// M1 smoke test — verifies the theme system builds (under ScreenUtil, since
// the type scale uses `.sp`) and that dark is the default with the design
// canvas + registered token extensions.
//
// Full section/widget tests (with easy_localization + Cubits) arrive in M3+
// per plan.md §13.

import 'package:clever_portfolio/core/theme/app_theme.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('M1: themes build under ScreenUtil; dark is default', (
    tester,
  ) async {
    late ThemeData applied;
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(1440, 1024),
        builder: (context, child) => MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.dark,
          home: Builder(
            builder: (context) {
              applied = Theme.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    expect(applied.brightness, Brightness.dark);
    expect(applied.scaffoldBackgroundColor, const Color(0xFF0A0C10));
    expect(applied.extension<AppSpacing>(), isNotNull);
    expect(applied.extension<BrandColors>(), isNotNull);
    expect(applied.extension<CategoryColors>(), isNotNull);
    expect(applied.extension<MotionTokens>(), isNotNull);
  });
}
