import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_platform.dart';
import 'package:equatable/equatable.dart';

/// A published app in the portfolio (plan.md §6.1). Pure domain value object —
/// store URLs are reconstructed in the data layer, so a URL is non-null only
/// when the app actually ships on that platform.
class AppProject extends Equatable {
  /// Creates an [AppProject].
  const AppProject({
    required this.index,
    required this.id,
    required this.name,
    required this.tagline,
    required this.category,
    required this.platforms,
    this.androidUrl,
    this.iosUrl,
    this.iconAsset,
    this.description,
    this.screenshots = const [],
    this.featured = false,
  });

  /// 1-based position in the catalog (1–37).
  final int index;

  /// Stable slug id.
  final String id;

  /// Display name.
  final String name;

  /// One-line role descriptor.
  final String tagline;

  /// Category.
  final AppCategory category;

  /// Platforms the app ships on.
  final List<AppPlatform> platforms;

  /// Google Play URL (null if not on Android).
  final String? androidUrl;

  /// App Store URL (null if not on iOS).
  final String? iosUrl;

  /// Bundled icon asset path (null → letter-tile placeholder).
  final String? iconAsset;

  /// Store description (may be in the app's native language).
  final String? description;

  /// Bundled screenshot asset paths.
  final List<String> screenshots;

  /// Whether this app is a featured highlight.
  final bool featured;

  /// True when a Google Play link exists.
  bool get hasAndroid => androidUrl != null;

  /// True when an App Store link exists.
  bool get hasIos => iosUrl != null;

  /// True when screenshots are available.
  bool get hasScreenshots => screenshots.isNotEmpty;

  /// Zero-padded index label, e.g. `"07"`.
  String get indexLabel => index.toString().padLeft(2, '0');

  @override
  List<Object?> get props => [
    index,
    id,
    name,
    tagline,
    category,
    platforms,
    androidUrl,
    iosUrl,
    iconAsset,
    description,
    screenshots,
    featured,
  ];
}
