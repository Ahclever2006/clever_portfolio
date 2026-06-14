import 'package:clever_portfolio/core/constants/app_strings.dart';
import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/app_text_link.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Folio 10 — footer / colophon.
class FooterSection extends StatelessWidget {
  /// Creates a [FooterSection]; [onBackToTop] scrolls to the hero.
  const FooterSection({required this.onBackToTop, super.key});

  /// Back-to-top callback.
  final VoidCallback onBackToTop;

  @override
  Widget build(BuildContext context) {
    const wordmark = 'ahmed.maher';
    const typefaces = 'Space Grotesk · Inter · JetBrains Mono';
    final year = DateTime.now().year.toString();
    final hPad = context.responsive(
      mobile: context.spacing.gutterMobile,
      desktop: context.spacing.gutterDesktop,
    );

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
                Text(
                  typefaces,
                  style: AppTypography.captionMono.copyWith(
                    color: context.brand.folio,
                  ),
                ),
                SizedBox(height: context.spacing.lg.h),
                Row(
                  children: [
                    AppTextLink(
                      label: AppStrings.footerBackToTop.tr(),
                      onTap: onBackToTop,
                    ),
                    const Spacer(),
                    Text(
                      AppStrings.footerRights.tr(namedArgs: {'year': year}),
                      style: AppTypography.captionMono.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
