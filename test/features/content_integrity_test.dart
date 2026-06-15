// Parses the REAL bundled content through the data sources — guards apps.json
// (valid categories, contiguous unique indices 1..N) and profile.json.
// The catalog grows over time, so the count is derived from the data rather
// than hard-coded; the invariant under test is contiguity + a sane floor.

import 'package:clever_portfolio/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:clever_portfolio/features/projects/data/datasources/projects_local_data_source.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'apps.json parses to N projects with contiguous unique indices 1..N',
    () async {
      final models = await ProjectsLocalDataSourceImpl(
        rootBundle,
      ).getProjects();
      final count = models.length;

      // Sane floor: a load that silently returns nothing/very little is a bug.
      expect(
        count,
        greaterThanOrEqualTo(35),
        reason: 'expected the published catalog, got $count entries',
      );

      final entities = models.map((m) => m.toEntity()).toList();
      // Indices are unique and contiguous 1..N (no gaps, no duplicates).
      expect(entities.map((e) => e.index).toSet(), {
        for (var i = 1; i <= count; i++) i,
      });
      // Every app has at least one platform/store link.
      expect(entities.every((e) => e.platforms.isNotEmpty), isTrue);
      // Featured highlights present.
      expect(entities.where((e) => e.featured).length, greaterThanOrEqualTo(5));
    },
  );

  test('profile.json parses into the CV aggregate', () async {
    final profile = (await ProfileLocalDataSourceImpl(
      rootBundle,
    ).getProfile()).toEntity();
    expect(profile.name, 'Ahmed Maher');
    expect(profile.experience, isNotEmpty);
    expect(profile.skillGroups, isNotEmpty);
    expect(profile.stats, isNotEmpty);
    expect(profile.languages, isNotEmpty);
  });
}
