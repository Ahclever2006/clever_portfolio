import 'package:clever_portfolio/core/abstract/base_cubit.dart';
import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/features/profile/domain/usecases/get_profile.dart';
import 'package:clever_portfolio/features/profile/presentation/cubit/profile_state.dart';
import 'package:injectable/injectable.dart';

/// Loads and holds the profile / CV.
@injectable
class ProfileCubit extends BaseCubit<ProfileState> {
  /// Creates the cubit.
  ProfileCubit(this._getProfile) : super(const ProfileState.initial());

  final GetProfile _getProfile;

  /// Loads the profile.
  Future<void> load() async {
    emit(const ProfileState.loading());
    final result = await _getProfile(const NoParams());
    result.fold(
      (failure) => emit(ProfileState.error(failure)),
      (profile) => emit(ProfileState.loaded(profile)),
    );
  }
}
