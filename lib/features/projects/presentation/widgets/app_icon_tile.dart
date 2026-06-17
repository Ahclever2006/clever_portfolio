import 'package:clever_portfolio/core/theme/theme_extensions.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/presentation/widgets/category_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App icon, or a category-tinted letter tile when no icon is bundled.
class AppIconTile extends StatelessWidget {
  /// Creates an [AppIconTile] of [size] logical px (square).
  const AppIconTile({required this.project, this.size = 48, super.key});

  /// The project whose icon to render.
  final AppProject project;

  /// Tile edge length in logical px.
  final double size;

  @override
  Widget build(BuildContext context) {
    final dim = size.r;
    final radius = BorderRadius.circular(context.radii.card.r);
    final icon = project.iconAsset;
    if (icon != null) {
      // Decode at the tile's device-pixel size, not the source res — a 512/1024px
      // icon in a ~52px tile otherwise holds a multi-MB bitmap in the cache.
      final cache = (dim * MediaQuery.devicePixelRatioOf(context)).round();
      return ClipRRect(
        borderRadius: radius,
        child: Image.asset(
          icon,
          width: dim,
          height: dim,
          fit: BoxFit.cover,
          cacheWidth: cache,
          cacheHeight: cache,
        ),
      );
    }
    final hue = project.category.hue(context);
    return Container(
      width: dim,
      height: dim,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: hue.withValues(alpha: 0.14),
        borderRadius: radius,
        border: Border.all(color: hue.withValues(alpha: 0.4)),
      ),
      child: Text(
        project.name.characters.first.toUpperCase(),
        style: context.text.titleLarge?.copyWith(color: hue),
      ),
    );
  }
}
