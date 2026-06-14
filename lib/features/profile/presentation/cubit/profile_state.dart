import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

/// State for [ProfileCubit].
@freezed
sealed class ProfileState with _$ProfileState {
  /// Before load.
  const factory ProfileState.initial() = ProfileInitial;

  /// Loading.
  const factory ProfileState.loading() = ProfileLoading;

  /// Loaded.
  const factory ProfileState.loaded(Profile profile) = ProfileLoaded;

  /// Load failed.
  const factory ProfileState.error(Failure failure) = ProfileError;
}
