import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_platform.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'projects_state.freezed.dart';

/// Work view: dense list (default) or card grid.
enum ProjectViewMode { list, grid }

/// State for [ProjectsCubit] (plan.md §5.4).
@freezed
sealed class ProjectsState with _$ProjectsState {
  /// Before load.
  const factory ProjectsState.initial() = ProjectsInitial;

  /// Loading.
  const factory ProjectsState.loading() = ProjectsLoading;

  /// Load failed.
  const factory ProjectsState.error(Failure failure) = ProjectsError;

  /// Loaded with the active filter applied to [visible].
  const factory ProjectsState.loaded({
    required List<AppProject> all,
    required List<AppProject> visible,
    AppCategory? activeCategory,
    AppPlatform? activePlatform,
    @Default('') String query,
    @Default(ProjectViewMode.grid) ProjectViewMode viewMode,
  }) = ProjectsLoaded;
}
