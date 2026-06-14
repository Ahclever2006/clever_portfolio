import 'dart:convert';

import 'package:clever_portfolio/core/constants/app_assets.dart';
import 'package:clever_portfolio/core/error/exceptions.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/profile/data/models/profile_model.dart';
import 'package:flutter/services.dart' show AssetBundle;
import 'package:injectable/injectable.dart';

/// Reads the bundled `profile.json`.
abstract class ProfileLocalDataSource {
  /// Parses the profile model; throws [AssetException] on failure.
  Future<ProfileModel> getProfile();
}

@LazySingleton(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  /// Creates the impl over an injected [AssetBundle].
  const ProfileLocalDataSourceImpl(this._bundle);

  final AssetBundle _bundle;

  @override
  Future<ProfileModel> getProfile() async {
    try {
      final raw = await _bundle.loadString(AppAssets.profileJson);
      return ProfileModel.fromJson(jsonDecode(raw) as DataMap);
    } on Object catch (e, s) {
      throw AssetException('profile.json: $e', s);
    }
  }
}
