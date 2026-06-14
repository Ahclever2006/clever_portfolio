import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/theme/app_theme.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_cubit.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_state.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/core/widgets/app_filter_chip.dart';
import 'package:clever_portfolio/core/widgets/app_platform_chip.dart';
import 'package:clever_portfolio/core/widgets/app_skill_chip.dart';
import 'package:clever_portfolio/core/widgets/app_text_link.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Root widget.
///
/// M1: provides [ThemeCubit], initializes flutter_screenutil, and renders a
/// theme/components demo (replaced by real sections in M4). M2 swaps in
/// `MaterialApp.router` + go_router + DI (plan.md §5.5).
class PortfolioApp extends StatelessWidget {
  /// Creates the root portfolio app.
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit()..load(),
      child: ScreenUtilInit(
        designSize: const Size(1440, 1024),
        minTextAdapt: true,
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return MaterialApp(
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
                home: const ThemeDemoPage(),
              );
            },
          );
        },
      ),
    );
  }
}

/// Temporary M1 showcase: verifies the theme system, atomic widgets, and the
/// theme/language toggles. Replaced by the real long-scroll page in M4.
class ThemeDemoPage extends StatelessWidget {
  /// Creates the demo page.
  const ThemeDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appTitle.tr(), style: context.text.titleMedium),
        actions: [
          IconButton(
            tooltip: 'Toggle language', // no-tr
            icon: const Icon(Icons.translate),
            onPressed: () {
              final next = context.locale.languageCode == 'en'
                  ? const Locale('ar')
                  : const Locale('en');
              context.setLocale(next);
            },
          ),
          IconButton(
            tooltip: 'Toggle theme', // no-tr
            icon: const Icon(Icons.brightness_6_outlined),
            onPressed: () => context.read<ThemeCubit>().toggle(),
          ),
          SizedBox(width: context.spacing.sm.w),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.spacing.maxContentWidth,
          ),
          child: ListView(
            padding: EdgeInsets.all(context.spacing.lg.w),
            children: [
              Text(
                '// design system — M1',
                style: context.text.labelMedium,
              ), // no-tr
              SizedBox(height: context.spacing.sm.h),
              Text('Ahmed Maher', style: context.text.displayMedium), // no-tr
              SizedBox(height: context.spacing.sm.h),
              Text(
                'Flutter Team Lead — 37 apps shipped to the App Store and Google Play.', // no-tr
                style: context.text.bodyLarge,
              ),
              SizedBox(height: context.spacing.xl.h),
              Wrap(
                spacing: context.spacing.sm.w,
                runSpacing: context.spacing.sm.h,
                children: [
                  AppButton(label: 'View Work', onPressed: () {}), // no-tr
                  AppButton.ghost(
                    label: 'Download CV', // no-tr
                    onPressed: () {},
                    icon: Icons.download_outlined,
                  ),
                ],
              ),
              SizedBox(height: context.spacing.lg.h),
              Wrap(
                spacing: context.spacing.sm.w,
                runSpacing: context.spacing.sm.h,
                children: [
                  AppFilterChip(
                    label: 'All', // no-tr
                    selected: true,
                    onTap: () {},
                  ),
                  AppFilterChip(
                    label: 'Games', // no-tr
                    selected: false,
                    onTap: () {},
                    accent: context.categoryColors.games,
                  ),
                  const AppPlatformChip(label: 'iOS'), // no-tr
                  const AppPlatformChip(label: 'Android'), // no-tr
                  const AppSkillChip(label: 'Flutter'), // no-tr
                  const AppSkillChip(label: 'BLoC'), // no-tr
                ],
              ),
              SizedBox(height: context.spacing.lg.h),
              AppTextLink(
                label: 'github.com/ahmedmaher',
                onTap: () {},
              ), // no-tr
            ],
          ),
        ),
      ),
    );
  }
}
