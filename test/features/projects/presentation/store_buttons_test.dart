import 'package:clever_portfolio/core/theme/app_theme.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/store_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

AppProject _project({String? ios, String? android}) => AppProject(
  index: 1,
  id: 'x',
  name: 'X',
  tagline: 't',
  category: AppCategory.games,
  platforms: const [],
  iosUrl: ios,
  androidUrl: android,
);

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(1440, 1024),
      builder: (context, _) => MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: child),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('iOS-only project shows App Store only', (tester) async {
    await _pump(
      tester,
      StoreButtons(project: _project(ios: 'https://apps.apple.com/app/id1')),
    );
    expect(find.text('App Store'), findsOneWidget);
    expect(find.text('Google Play'), findsNothing);
  });

  testWidgets('android-only project shows Google Play only', (tester) async {
    await _pump(
      tester,
      StoreButtons(project: _project(android: 'https://play.google.com/x')),
    );
    expect(find.text('Google Play'), findsOneWidget);
    expect(find.text('App Store'), findsNothing);
  });

  testWidgets('cross-platform project shows both buttons', (tester) async {
    await _pump(
      tester,
      StoreButtons(
        project: _project(ios: 'a', android: 'b'),
      ),
    );
    expect(find.text('App Store'), findsOneWidget);
    expect(find.text('Google Play'), findsOneWidget);
  });
}
