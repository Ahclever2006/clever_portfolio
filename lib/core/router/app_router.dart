import 'package:clever_portfolio/app/view/home_page.dart';
import 'package:clever_portfolio/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

/// App router — one `/` route for the single-scroll page (plan.md §9).
/// `MaterialApp.router` consumes [config].
@lazySingleton
class AppRouter {
  final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (BuildContext context, GoRouterState state) =>
            const HomePage(),
      ),
    ],
  );

  /// The router config consumed by `MaterialApp.router`.
  GoRouter get config => _router;
}
