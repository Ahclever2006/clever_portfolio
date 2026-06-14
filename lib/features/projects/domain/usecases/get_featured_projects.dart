import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/domain/repositories/projects_repository.dart';
import 'package:injectable/injectable.dart';

/// Loads only the featured highlight apps.
@injectable
class GetFeaturedProjects extends UseCase<List<AppProject>, NoParams> {
  /// Creates the use case.
  const GetFeaturedProjects(this._repository);

  final ProjectsRepository _repository;

  @override
  ResultFuture<List<AppProject>> call(NoParams params) =>
      _repository.getFeaturedProjects();
}
