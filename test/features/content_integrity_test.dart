// Parses the REAL bundled content through the data sources — guards apps.json
// (37 entries, valid categories, unique indices) and profile.json.

import 'package:clever_portfolio/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:clever_portfolio/features/projects/data/datasources/projects_local_data_source.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('apps.json parses to 37 projects with unique indices 1..37', () async {
    final models = await ProjectsLocalDataSourceImpl(rootBundle).getProjects();
    expect(models, hasLength(37));

    final entities = models.map((m) => m.toEntity()).toList();
    expect(entities.map((e) => e.index).toSet(), {
      for (var i = 1; i <= 37; i++) i,
    });
    // Every app has at least one platform/store link.
    expect(entities.every((e) => e.platforms.isNotEmpty), isTrue);
    // Featured highlights present.
    expect(entities.where((e) => e.featured).length, greaterThanOrEqualTo(5));
  });

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
