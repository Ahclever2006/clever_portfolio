// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoreLinksModel _$StoreLinksModelFromJson(Map<String, dynamic> json) =>
    _StoreLinksModel(
      googlePlay: json['googlePlay'] as String?,
      appStore: json['appStore'] as String?,
    );

Map<String, dynamic> _$StoreLinksModelToJson(_StoreLinksModel instance) =>
    <String, dynamic>{
      'googlePlay': instance.googlePlay,
      'appStore': instance.appStore,
    };

_AppProjectModel _$AppProjectModelFromJson(Map<String, dynamic> json) =>
    _AppProjectModel(
      index: (json['index'] as num).toInt(),
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      tagline: json['tagline'] as String,
      featured: json['featured'] as bool? ?? false,
      storeLinks: json['storeLinks'] == null
          ? null
          : StoreLinksModel.fromJson(
              json['storeLinks'] as Map<String, dynamic>,
            ),
      iconAsset: json['iconAsset'] as String?,
      description: json['description'] as String?,
      screenshots:
          (json['screenshots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$AppProjectModelToJson(_AppProjectModel instance) =>
    <String, dynamic>{
      'index': instance.index,
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'tagline': instance.tagline,
      'featured': instance.featured,
      'storeLinks': instance.storeLinks,
      'iconAsset': instance.iconAsset,
      'description': instance.description,
      'screenshots': instance.screenshots,
    };
