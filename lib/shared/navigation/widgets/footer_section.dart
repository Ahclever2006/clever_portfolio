import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/utils/app_launcher.dart';
import 'package:clever_portfolio/core/widgets/app_button.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Folio 10 — footer / colophon.
class FooterSection extends StatelessWidget {
  /// Creates a [FooterSection].
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    const wordmark = 'ahmed.maher';
    final year = DateTime.now().year.toString();
    final hPad = context.responsive(
      mobile: context.spacing.gutterMobile,
      desktop: context.spacing.gutterDesktop,
    );
    final profileState = context.watch<ProfileCubit>().state;
    final phone = profileState is ProfileLoaded
        ? profileState.profile.phone
        : null;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.colors.outline)),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: hPad.w,
          vertical: context.spacing.xxl.h,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.spacing.maxContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wordmark,
                  style: AppTypography.eyebrowMono.copyWith(
                    color: context.colors.primary,
                  ),
                ),
                SizedBox(height: context.spacing.sm.h),
                Text(
                  AppStrings.footerBuiltWith.tr(),
                  style: AppTypography.captionMono.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                if (phone != null) ...[
                  SizedBox(height: context.spacing.md.h),
                  AppButton.ghost(
                    label: 'WhatsApp', // no-tr
                    icon: FontAwesomeIcons.whatsapp,
                    onPressed: () => AppLauncher.whatsApp(phone),
                  ),
                ],
                SizedBox(height: context.spacing.lg.h),
                Text(
                  AppStrings.footerRights.tr(namedArgs: {'year': year}),
                  style: AppTypography.captionMono.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
