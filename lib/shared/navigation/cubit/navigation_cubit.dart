import 'package:clever_portfolio/core/abstract/base_cubit.dart';
import 'package:clever_portfolio/shared/navigation/cubit/navigation_state.dart';
import 'package:clever_portfolio/shared/navigation/section_id.dart';
import 'package:injectable/injectable.dart';

/// Tracks the active section (for nav highlighting) and whether the nav is
/// elevated (scrolled past the hero). Driven by scroll / VisibilityDetector.
@injectable
class NavigationCubit extends BaseCubit<NavigationState> {
  /// Creates the cubit.
  NavigationCubit() : super(const NavigationState());

  /// Marks [id] as the active section.
  void setActive(SectionId id) {
    if (state.activeSection != id) {
      emit(state.copyWith(activeSection: id));
    }
  }

  /// Sets whether the nav is elevated.
  void setElevated({required bool value}) {
    if (state.navElevated != value) {
      emit(state.copyWith(navElevated: value));
    }
  }
}
