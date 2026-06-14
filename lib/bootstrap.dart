import 'package:clever_portfolio/app/portfolio_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// App bootstrap: framework binding + localization init, then `runApp`.
///
/// M1 adds `Bloc.observer` + ThemeCubit/LocaleCubit providers; M2 adds DI
/// (`configureDependencies`) + `setUrlStrategy(PathUrlStrategy())` for clean
/// web URLs (see plan.md §5.5).
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const PortfolioApp(),
    ),
  );
}
