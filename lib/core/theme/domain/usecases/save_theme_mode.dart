import 'package:clever_portfolio/core/theme/domain/theme_repository.dart';
import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:injectable/injectable.dart';

/// Persists the theme mode.
@injectable
class SaveThemeMode extends UseCase<Unit, ThemeMode> {
  /// Creates the use case.
  const SaveThemeMode(this._repository);

  final ThemeRepository _repository;

  @override
  ResultVoid call(ThemeMode params) => _repository.saveThemeMode(params);
}
