import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_platform.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

/// Inputs for [FilterProjects].
class ProjectFilter extends Equatable {
  /// Creates a filter over [source].
  const ProjectFilter({
    required this.source,
    this.category,
    this.platform,
    this.query = '',
  });

  /// The full list to filter.
  final List<AppProject> source;

  /// Category filter (null = all).
  final AppCategory? category;

  /// Platform filter (null = both).
  final AppPlatform? platform;

  /// Free-text query.
  final String query;

  @override
  List<Object?> get props => [source, category, platform, query];
}

/// Pure in-memory filter: category + platform + text. Always succeeds, but
/// stays inside the `Either` contract for uniformity (plan.md §5.2).
@injectable
class FilterProjects extends SyncUseCase<List<AppProject>, ProjectFilter> {
  /// Creates the use case.
  const FilterProjects();

  @override
  Either<Failure, List<AppProject>> call(ProjectFilter params) {
    final q = params.query.trim().toLowerCase();
    final filtered = params.source
        .where((p) {
          final categoryOk =
              params.category == null || p.category == params.category;
          final platformOk =
              params.platform == null || p.platforms.contains(params.platform);
          final queryOk =
              q.isEmpty ||
              p.name.toLowerCase().contains(q) ||
              p.tagline.toLowerCase().contains(q) ||
              p.category.label.toLowerCase().contains(q);
          return categoryOk && platformOk && queryOk;
        })
        .toList(growable: false);
    return Right(filtered);
  }
}
