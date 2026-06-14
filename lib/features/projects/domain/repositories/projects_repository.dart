import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';

/// Source of portfolio apps (plan.md §5.3).
abstract class ProjectsRepository {
  /// All 37 apps.
  ResultFuture<List<AppProject>> getProjects();

  /// Only the featured highlights.
  ResultFuture<List<AppProject>> getFeaturedProjects();
}
