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
import 'package:clever_portfolio/features/contact/data/repositories/contact_repository_impl.dart'
    as _i81;
import 'package:clever_portfolio/features/contact/domain/repositories/contact_repository.dart'
    as _i178;
import 'package:clever_portfolio/features/contact/domain/usecases/send_message.dart'
    as _i300;
import 'package:clever_portfolio/features/contact/presentation/cubit/contact_cubit.dart'
    as _i476;
import 'package:clever_portfolio/features/profile/data/datasources/profile_local_data_source.dart'
    as _i625;
import 'package:clever_portfolio/features/profile/data/repositories/profile_repository_impl.dart'
    as _i584;
import 'package:clever_portfolio/features/profile/domain/repositories/profile_repository.dart'
    as _i819;
import 'package:clever_portfolio/features/profile/domain/usecases/get_profile.dart'
    as _i228;
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_cubit.dart'
    as _i975;
import 'package:clever_portfolio/features/projects/data/datasources/projects_local_data_source.dart'
    as _i924;
import 'package:clever_portfolio/features/projects/data/repositories/projects_repository_impl.dart'
    as _i388;
import 'package:clever_portfolio/features/projects/domain/repositories/projects_repository.dart'
    as _i196;
import 'package:clever_portfolio/features/projects/domain/usecases/filter_projects.dart'
    as _i538;
import 'package:clever_portfolio/features/projects/domain/usecases/get_featured_projects.dart'
    as _i255;
import 'package:clever_portfolio/features/projects/domain/usecases/get_projects.dart'
    as _i129;
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_cubit.dart'
    as _i213;
import 'package:clever_portfolio/shared/navigation/cubit/navigation_cubit.dart'
    as _i345;
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
    gh.factory<_i538.FilterProjects>(() => const _i538.FilterProjects());
    gh.factory<_i345.NavigationCubit>(() => _i345.NavigationCubit());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i281.AssetBundle>(() => registerModule.assetBundle);
    gh.lazySingleton<_i345.AppRouter>(() => _i345.AppRouter());
    gh.lazySingleton<_i923.DioClient>(() => _i923.DioClient(gh<_i361.Dio>()));
    gh.lazySingleton<_i178.ContactRepository>(
      () => _i81.ContactRepositoryImpl(gh<_i923.DioClient>()),
    );
    gh.lazySingleton<_i1071.ThemeRepository>(
      () => _i571.ThemeRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i924.ProjectsLocalDataSource>(
      () => _i924.ProjectsLocalDataSourceImpl(gh<_i281.AssetBundle>()),
    );
    gh.lazySingleton<_i625.ProfileLocalDataSource>(
      () => _i625.ProfileLocalDataSourceImpl(gh<_i281.AssetBundle>()),
    );
    gh.factory<_i268.GetThemeMode>(
      () => _i268.GetThemeMode(gh<_i1071.ThemeRepository>()),
    );
    gh.factory<_i1065.SaveThemeMode>(
      () => _i1065.SaveThemeMode(gh<_i1071.ThemeRepository>()),
    );
    gh.lazySingleton<_i196.ProjectsRepository>(
      () => _i388.ProjectsRepositoryImpl(gh<_i924.ProjectsLocalDataSource>()),
    );
    gh.factory<_i300.SendMessage>(
      () => _i300.SendMessage(gh<_i178.ContactRepository>()),
    );
    gh.factory<_i476.ContactCubit>(
      () => _i476.ContactCubit(gh<_i300.SendMessage>()),
    );
    gh.factory<_i255.GetFeaturedProjects>(
      () => _i255.GetFeaturedProjects(gh<_i196.ProjectsRepository>()),
    );
    gh.factory<_i129.GetProjects>(
      () => _i129.GetProjects(gh<_i196.ProjectsRepository>()),
    );
    gh.factory<_i213.ProjectsCubit>(
      () => _i213.ProjectsCubit(
        gh<_i129.GetProjects>(),
        gh<_i538.FilterProjects>(),
      ),
    );
    gh.lazySingleton<_i819.ProfileRepository>(
      () => _i584.ProfileRepositoryImpl(gh<_i625.ProfileLocalDataSource>()),
    );
    gh.factory<_i710.ThemeCubit>(
      () => _i710.ThemeCubit(
        gh<_i268.GetThemeMode>(),
        gh<_i1065.SaveThemeMode>(),
      ),
    );
    gh.factory<_i228.GetProfile>(
      () => _i228.GetProfile(gh<_i819.ProfileRepository>()),
    );
    gh.factory<_i975.ProfileCubit>(
      () => _i975.ProfileCubit(gh<_i228.GetProfile>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i150.RegisterModule {}
