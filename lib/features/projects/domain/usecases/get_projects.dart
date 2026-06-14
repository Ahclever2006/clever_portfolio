import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/domain/repositories/projects_repository.dart';
import 'package:injectable/injectable.dart';

/// Loads all apps.
@injectable
class GetProjects extends UseCase<List<AppProject>, NoParams> {
  /// Creates the use case.
  const GetProjects(this._repository);

  final ProjectsRepository _repository;

  @override
  ResultFuture<List<AppProject>> call(NoParams params) =>
      _repository.getProjects();
}
