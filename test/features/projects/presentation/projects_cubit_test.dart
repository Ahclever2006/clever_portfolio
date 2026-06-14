import 'package:bloc_test/bloc_test.dart';
import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_category.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_platform.dart';
import 'package:clever_portfolio/features/projects/domain/entities/app_project.dart';
import 'package:clever_portfolio/features/projects/domain/usecases/filter_projects.dart';
import 'package:clever_portfolio/features/projects/domain/usecases/get_projects.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetProjects extends Mock implements GetProjects {}

void main() {
  late _MockGetProjects getProjects;
  const filterProjects = FilterProjects(); // real sync use case

  const apps = [
    AppProject(
      index: 1,
      id: 'a',
      name: 'Alpha',
      tagline: 't',
      category: AppCategory.games,
      platforms: [AppPlatform.android, AppPlatform.ios],
    ),
    AppProject(
      index: 2,
      id: 'b',
      name: 'Beta',
      tagline: 't',
      category: AppCategory.ecommerce,
      platforms: [AppPlatform.ios],
    ),
  ];

  setUpAll(() => registerFallbackValue(const NoParams()));
  setUp(() => getProjects = _MockGetProjects());

  ProjectsCubit build() {
    when(() => getProjects(any())).thenAnswer((_) async => const Right(apps));
    return ProjectsCubit(getProjects, filterProjects);
  }

  blocTest<ProjectsCubit, ProjectsState>(
    'load emits [loading, loaded(2)]',
    build: build,
    act: (c) => c.load(),
    expect: () => [
      const ProjectsState.loading(),
      isA<ProjectsLoaded>().having((s) => s.visible.length, 'visible', 2),
    ],
  );

  blocTest<ProjectsCubit, ProjectsState>(
    'setCategory(games) narrows visible to 1',
    build: build,
    act: (c) async {
      await c.load();
      c.setCategory(AppCategory.games);
    },
    skip: 2,
    expect: () => [
      isA<ProjectsLoaded>()
          .having((s) => s.visible.length, 'visible', 1)
          .having((s) => s.activeCategory, 'category', AppCategory.games),
    ],
  );

  blocTest<ProjectsCubit, ProjectsState>(
    'setPlatform(android) narrows visible to 1',
    build: build,
    act: (c) async {
      await c.load();
      c.setPlatform(AppPlatform.android);
    },
    skip: 2,
    expect: () => [
      isA<ProjectsLoaded>().having((s) => s.visible.length, 'visible', 1),
    ],
  );

  blocTest<ProjectsCubit, ProjectsState>(
    'search("beta") narrows visible to 1',
    build: build,
    act: (c) async {
      await c.load();
      c.search('beta');
    },
    skip: 2,
    expect: () => [
      isA<ProjectsLoaded>().having((s) => s.visible.first.name, 'name', 'Beta'),
    ],
  );

  blocTest<ProjectsCubit, ProjectsState>(
    'toggleViewMode flips grid -> list (grid is the default)',
    build: build,
    act: (c) async {
      await c.load();
      c.toggleViewMode();
    },
    skip: 2,
    expect: () => [
      isA<ProjectsLoaded>().having(
        (s) => s.viewMode,
        'viewMode',
        ProjectViewMode.list,
      ),
    ],
  );
}
