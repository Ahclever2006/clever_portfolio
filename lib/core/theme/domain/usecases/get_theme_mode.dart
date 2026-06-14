import 'package:clever_portfolio/core/theme/domain/theme_repository.dart';
import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:injectable/injectable.dart';

/// Reads the persisted theme mode.
@injectable
class GetThemeMode extends UseCase<ThemeMode, NoParams> {
  /// Creates the use case.
  const GetThemeMode(this._repository);

  final ThemeRepository _repository;

  @override
  ResultFuture<ThemeMode> call(NoParams params) => _repository.getThemeMode();
}
