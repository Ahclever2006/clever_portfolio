// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clever_portfolio/core/di/register_module.dart' as _i150;
import 'package:clever_portfolio/core/network/dio_client.dart' as _i923;
import 'package:clever_portfolio/core/router/app_router.dart' as _i345;
import 'package:clever_portfolio/core/theme/cubit/theme_cubit.dart' as _i710;
import 'package:clever_portfolio/core/theme/data/theme_repository_impl.dart'
    as _i571;
import 'package:clever_portfolio/core/theme/domain/theme_repository.dart'
    as _i1071;
import 'package:clever_portfolio/core/theme/domain/usecases/get_theme_mode.dart'
    as _i268;
import 'package:clever_portfolio/core/theme/domain/usecases/save_theme_mode.dart'
    as _i1065;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter/services.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i281.AssetBundle>(() => registerModule.assetBundle);
    gh.lazySingleton<_i345.AppRouter>(() => _i345.AppRouter());
    gh.lazySingleton<_i923.DioClient>(() => _i923.DioClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i1071.ThemeRepository>(
      () => _i571.ThemeRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i268.GetThemeMode>(
      () => _i268.GetThemeMode(gh<_i1071.ThemeRepository>()),
    );
    gh.factory<_i1065.SaveThemeMode>(
      () => _i1065.SaveThemeMode(gh<_i1071.ThemeRepository>()),
    );
    gh.factory<_i710.ThemeCubit>(
      () => _i710.ThemeCubit(
        gh<_i268.GetThemeMode>(),
        gh<_i1065.SaveThemeMode>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i150.RegisterModule {}
