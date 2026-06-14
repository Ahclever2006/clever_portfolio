// M2: verifies the get_it/injectable graph resolves end-to-end (catches
// missing registrations / unsatisfied dependencies that compilation can't).

import 'package:clever_portfolio/core/di/injection.dart';
import 'package:clever_portfolio/core/network/dio_client.dart';
import 'package:clever_portfolio/core/router/app_router.dart';
import 'package:clever_portfolio/core/theme/cubit/theme_cubit.dart';
import 'package:clever_portfolio/core/theme/domain/theme_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({}); // backs the @preResolve prefs
    await configureDependencies();
  });

  test('DI graph resolves the core dependencies', () {
    expect(getIt<ThemeRepository>(), isA<ThemeRepository>());
    expect(getIt<ThemeCubit>(), isA<ThemeCubit>());
    expect(getIt<AppRouter>(), isA<AppRouter>());
    expect(getIt<DioClient>(), isA<DioClient>());
  });

  test('ThemeCubit defaults to dark (dark-first)', () {
    expect(getIt<ThemeCubit>().mode.name, 'dark');
  });
}
