import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_cubit.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/core/widgets/app_filter_chip.dart';
import 'package:clever_portfolio/core/widgets/app_platform_chip.dart';
import 'package:clever_portfolio/core/widgets/app_skill_chip.dart';
import 'package:clever_portfolio/core/widgets/app_text_link.dart';
import 'package:clever_portfolio/core/widgets/terminal_status_strip.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The single-page host (route `/`).
///
/// M2 placeholder: showcases the design system + theme/language toggles.
/// M4 replaces the body with the real long-scroll sections (Hero, Index, …).
class HomePage extends StatelessWidget {
  /// Creates the home page.
  const HomePage({super.key});

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
              const TerminalStatusStrip(
                text:
                    'apps_shipped: 37 | platforms: ios + android | status: live',
              ),
              SizedBox(height: context.spacing.md.h),
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
                    label: 'All',
                    selected: true,
                    onTap: () {},
                  ), // no-tr
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
