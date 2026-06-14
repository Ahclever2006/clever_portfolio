import 'package:clever_portfolio/shared/navigation/section_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_state.freezed.dart';

/// State for [NavigationCubit] — active section + nav elevation.
@freezed
sealed class NavigationState with _$NavigationState {
  /// Creates a [NavigationState].
  const factory NavigationState({
    @Default(SectionId.hero) SectionId activeSection,
    @Default(false) bool navElevated,
  }) = _NavigationState;
}
