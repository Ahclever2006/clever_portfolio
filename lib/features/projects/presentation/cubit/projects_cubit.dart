import 'package:clever_portfolio/core/abstract/base_cubit.dart';
import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_platform.dart';
import 'package:clever_portfolio/features/projects/domain/usecases/filter_projects.dart';
import 'package:clever_portfolio/features/projects/domain/usecases/get_projects.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_state.dart';
import 'package:injectable/injectable.dart';

/// Loads the catalog and applies category / platform / search filters + view
/// mode (plan.md §5.4).
@injectable
class ProjectsCubit extends BaseCubit<ProjectsState> {
  /// Creates the cubit.
  ProjectsCubit(this._getProjects, this._filterProjects)
    : super(const ProjectsState.initial());

  final GetProjects _getProjects;
  final FilterProjects _filterProjects;

  /// Loads all projects.
  Future<void> load() async {
    emit(const ProjectsState.loading());
    final result = await _getProjects(const NoParams());
    result.fold(
      (failure) => emit(ProjectsState.error(failure)),
      (all) => emit(ProjectsState.loaded(all: all, visible: all)),
    );
  }

  /// Sets the active category (null = all).
  void setCategory(AppCategory? category) =>
      _refilter(category: () => category);

  /// Sets the active platform (null = both).
  void setPlatform(AppPlatform? platform) =>
      _refilter(platform: () => platform);

  /// Updates the search query.
  void search(String query) => _refilter(query: query);

  /// Flips list ↔ grid.
  void toggleViewMode() {
    final s = state;
    if (s is! ProjectsLoaded) return;
    emit(
      s.copyWith(
        viewMode: s.viewMode == ProjectViewMode.list
            ? ProjectViewMode.grid
            : ProjectViewMode.list,
      ),
    );
  }

  // Closures distinguish "set to null" from "leave unchanged".
  void _refilter({
    AppCategory? Function()? category,
    AppPlatform? Function()? platform,
    String? query,
  }) {
    final s = state;
    if (s is! ProjectsLoaded) return;
    final nextCategory = category != null ? category() : s.activeCategory;
    final nextPlatform = platform != null ? platform() : s.activePlatform;
    final nextQuery = query ?? s.query;
    final result = _filterProjects(
      ProjectFilter(
        source: s.all,
        category: nextCategory,
        platform: nextPlatform,
        query: nextQuery,
      ),
    );
    result.fold((_) {}, (visible) {
      emit(
        s.copyWith(
          visible: visible,
          activeCategory: nextCategory,
          activePlatform: nextPlatform,
          query: nextQuery,
        ),
      );
    });
  }
}
