import 'package:clever_portfolio/core/utils/store_link_builder.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_platform.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_project_model.freezed.dart';
part 'app_project_model.g.dart';

/// Raw store ids as they appear in `apps.json`.
@freezed
sealed class StoreLinksModel with _$StoreLinksModel {
  /// Creates a [StoreLinksModel].
  const factory StoreLinksModel({String? googlePlay, String? appStore}) =
      _StoreLinksModel;

  /// JSON factory.
  factory StoreLinksModel.fromJson(Map<String, dynamic> json) =>
      _$StoreLinksModelFromJson(json);
}

/// Data model for an app entry in `apps.json` (plan.md §6.3).
@freezed
sealed class AppProjectModel with _$AppProjectModel {
  const AppProjectModel._();

  /// Creates an [AppProjectModel].
  const factory AppProjectModel({
    required int index,
    required String id,
    required String name,
    required String category,
    required String tagline,
    @Default(false) bool featured,
    StoreLinksModel? storeLinks,
    String? iconAsset,
    String? description,
    @Default(<String>[]) List<String> screenshots,
  }) = _AppProjectModel;

  /// JSON factory.
  factory AppProjectModel.fromJson(Map<String, dynamic> json) =>
      _$AppProjectModelFromJson(json);

  /// Maps to the domain entity, reconstructing store URLs from raw ids and
  /// deriving the platform list from which links exist.
  AppProject toEntity() {
    final android = StoreLinkBuilder.googlePlay(storeLinks?.googlePlay);
    final ios = StoreLinkBuilder.appStore(storeLinks?.appStore);
    return AppProject(
      index: index,
      id: id,
      name: name,
      tagline: tagline,
      category: AppCategory.fromKey(category),
      platforms: [
        if (android != null) AppPlatform.android,
        if (ios != null) AppPlatform.ios,
      ],
      androidUrl: android,
      iosUrl: ios,
      iconAsset: iconAsset,
      description: description,
      screenshots: screenshots,
      featured: featured,
    );
  }
}
