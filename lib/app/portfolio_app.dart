import 'package:clever_portfolio/core/di/injection.dart';
import 'package:clever_portfolio/core/responsive/screen_util_init.dart';
import 'package:clever_portfolio/core/router/app_router.dart';
import 'package:clever_portfolio/core/theme/app_theme.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_cubit.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Root widget: providers + ScreenUtil + `MaterialApp.router` (plan.md §5.5).
/// The page tree lives behind go_router (`/` → `HomePage`).
class PortfolioApp extends StatelessWidget {
  /// Creates the root portfolio app.
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<ThemeCubit>()..load())],
      child: AppScreenUtilInit(
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp.router(
                title: 'Ahmed Maher — Flutter Team Lead', // no-tr
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: context.read<ThemeCubit>().mode,
                themeAnimationDuration: const Duration(milliseconds: 300),
                themeAnimationCurve: Curves.easeOut,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                routerConfig: getIt<AppRouter>().config,
              );
            },
          );
        },
      ),
    );
  }
}
