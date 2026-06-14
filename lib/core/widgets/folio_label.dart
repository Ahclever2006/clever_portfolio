import 'package:clever_portfolio/core/theme/app_typography.dart';
import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Editorial mono folio (e.g. `00`–`10`) with an optional running head, used in
/// the sticky start-margin column of [SectionScaffold] (plan.md §3.6).
class FolioLabel extends StatelessWidget {
  /// Creates a [FolioLabel].
  const FolioLabel({required this.folio, this.label, super.key});

  /// Folio number string (e.g. `"05"`).
  final String folio;

  /// Optional running-head label.
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          folio,
          style: AppTypography.folioMono.copyWith(color: context.brand.folio),
        ),
        if (label != null) ...[
          SizedBox(height: context.spacing.xs.h),
          Text(
            label!,
            style: AppTypography.captionMono.copyWith(
              color: context.brand.folio,
            ),
          ),
        ],
      ],
    );
  }
}
