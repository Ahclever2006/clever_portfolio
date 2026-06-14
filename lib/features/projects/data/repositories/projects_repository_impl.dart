import 'package:clever_portfolio/core/error/exceptions.dart';
import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/projects/data/datasources/projects_local_data_source.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/domain/repositories/projects_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Maps local-data-source exceptions to [Failure]s (plan.md §5.3).
@LazySingleton(as: ProjectsRepository)
class ProjectsRepositoryImpl implements ProjectsRepository {
  /// Creates the impl over a [ProjectsLocalDataSource].
  const ProjectsRepositoryImpl(this._local);

  final ProjectsLocalDataSource _local;

  @override
  ResultFuture<List<AppProject>> getProjects() async {
    try {
      final models = await _local.getProjects();
      return Right(models.map((m) => m.toEntity()).toList(growable: false));
    } on AssetException catch (e) {
      return Left(AssetFailure(message: e.message));
    }
  }

  @override
  ResultFuture<List<AppProject>> getFeaturedProjects() async =>
      (await getProjects()).map(
        (all) => all.where((p) => p.featured).toList(growable: false),
      );
}
