import 'package:clever_portfolio/core/responsive/responsive.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/core/widgets/folio_label.dart';
import 'package:clever_portfolio/core/widgets/reveal_on_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Standard section frame (plan.md §4): a sticky start-margin folio column
/// (desktop only), a mono eyebrow, an animated hairline opener, and the
/// reveal-on-scroll content. The whole section is anchored by [sectionKey].
class SectionScaffold extends StatelessWidget {
  /// Creates a [SectionScaffold].
  const SectionScaffold({
    required this.folio,
    required this.eyebrow,
    required this.child,
    this.runningHead,
    this.sectionKey,
    super.key,
  });

  /// Folio number string (e.g. `"05"`).
  final String folio;

  /// Mono eyebrow text (already translated).
  final String eyebrow;

  /// Optional folio running-head.
  final String? runningHead;

  /// Section content.
  final Widget child;

  /// Anchor key for scroll navigation.
  final Key? sectionKey;

  @override
  Widget build(BuildContext context) {
    final vPad = context.responsive(
      mobile: context.spacing.sectionMobile,
      desktop: context.spacing.sectionDesktop,
    );
    final hPad = context.responsive(
      mobile: context.spacing.gutterMobile,
      desktop: context.spacing.gutterDesktop,
    );

    final content = RevealOnScroll(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(eyebrow, style: context.text.labelMedium),
          SizedBox(height: context.spacing.sm.h),
          _Hairline(),
          SizedBox(height: context.spacing.lg.h),
          child,
        ],
      ),
    );

    return KeyedSubtree(
      key: sectionKey,
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          vertical: vPad.h,
          horizontal: hPad.w,
        ),
        child: context.isDesktop
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 96.w,
                    child: FolioLabel(folio: folio, label: runningHead),
                  ),
                  Expanded(child: content),
                ],
              )
            : content,
      ),
    );
  }
}

/// 1px hairline that draws in horizontally (scaleX) as the section enters.
class _Hairline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final line = Container(
      height: 1.h,
      width: double.infinity,
      color: context.colors.outline,
    );
    if (MediaQuery.of(context).disableAnimations) return line;
    // Center-out draw — direction-neutral (no LTR/RTL alignment needed).
    return line.animate().scaleX(
      begin: 0,
      end: 1,
      duration: context.motion.hairline,
      curve: context.motion.curveEntrance,
    );
  }
}
