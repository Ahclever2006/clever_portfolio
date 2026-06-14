import 'dart:convert';

import 'package:clever_portfolio/core/constants/app_assets.dart';
import 'package:clever_portfolio/core/error/exceptions.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/projects/data/models/app_project_model.dart';
import 'package:flutter/services.dart' show AssetBundle;
import 'package:injectable/injectable.dart';

/// Reads the bundled `apps.json`.
abstract class ProjectsLocalDataSource {
  /// Parses all app models; throws [AssetException] on failure.
  Future<List<AppProjectModel>> getProjects();
}

@LazySingleton(as: ProjectsLocalDataSource)
class ProjectsLocalDataSourceImpl implements ProjectsLocalDataSource {
  /// Creates the impl over an injected [AssetBundle].
  const ProjectsLocalDataSourceImpl(this._bundle);

  final AssetBundle _bundle;

  @override
  Future<List<AppProjectModel>> getProjects() async {
    try {
      final raw = await _bundle.loadString(AppAssets.appsJson);
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => AppProjectModel.fromJson(e as DataMap))
          .toList(growable: false);
    } on Object catch (e, s) {
      throw AssetException('apps.json: $e', s);
    }
  }
}
