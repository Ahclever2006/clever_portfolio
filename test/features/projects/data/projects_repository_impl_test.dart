import 'package:clever_portfolio/core/error/exceptions.dart';
import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/features/projects/data/datasources/projects_local_data_source.dart';
import 'package:clever_portfolio/features/projects/data/models/app_project_model.dart';
import 'package:clever_portfolio/features/projects/data/repositories/projects_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockLocal extends Mock implements ProjectsLocalDataSource {}

void main() {
  late _MockLocal local;
  late ProjectsRepositoryImpl repo;

  setUp(() {
    local = _MockLocal();
    repo = ProjectsRepositoryImpl(local);
  });

  const featured = AppProjectModel(
    index: 1,
    id: 'a',
    name: 'A',
    category: 'games',
    tagline: 't',
    featured: true,
  );
  const plain = AppProjectModel(
    index: 2,
    id: 'b',
    name: 'B',
    category: 'games',
    tagline: 't',
  );

  test('getProjects maps models to entities on success', () async {
    when(() => local.getProjects()).thenAnswer((_) async => [featured, plain]);
    final result = await repo.getProjects();
    expect(result.isRight(), isTrue);
    result.fold((_) => fail('expected Right'), (l) => expect(l, hasLength(2)));
  });

  test('getProjects -> AssetFailure when data source throws', () async {
    when(() => local.getProjects()).thenThrow(const AssetException('boom'));
    final result = await repo.getProjects();
    result.fold(
      (f) => expect(f, isA<AssetFailure>()),
      (_) => fail('expected Left'),
    );
  });

  test('getFeaturedProjects keeps only featured', () async {
    when(() => local.getProjects()).thenAnswer((_) async => [featured, plain]);
    final result = await repo.getFeaturedProjects();
    result.fold((_) => fail('expected Right'), (l) {
      expect(l, hasLength(1));
      expect(l.first.featured, isTrue);
    });
  });
}
