import 'package:clever_portfolio/app/portfolio_app.dart';
import 'package:clever_portfolio/app/view/app_observer.dart';
import 'package:clever_portfolio/core/di/injection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

/// App bootstrap: binding, localization, Bloc observer, DI, clean web URLs,
/// then `runApp` (plan.md §5.5).
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppObserver();
  await configureDependencies();
  usePathUrlStrategy();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const PortfolioApp(),
    ),
  );
}
