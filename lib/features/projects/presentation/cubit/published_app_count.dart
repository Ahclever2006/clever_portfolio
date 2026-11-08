import 'package:clever_portfolio/features/projects/presentation/cubit/projects_cubit.dart';
import 'package:clever_portfolio/features/projects/presentation/cubit/projects_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Name of the live app-count placeholder. Content (`profile.json`) and
/// translations (`en.json` / `ar.json`, via `namedArgs`) write it as
/// `{appCount}`, so the number lives only in `apps.json`.
const String appCountArg = 'appCount';

/// Exposes the catalog size to sections outside the projects feature
/// (hero strip, stats band, about quote).
extension PublishedAppCountX on BuildContext {
  /// Total published apps (unfiltered), or `null` until [ProjectsCubit] has
  /// loaded. Uses `select`, so the caller rebuilds only when the count
  /// changes, not on every filter / search / view-mode emission.
  int? watchPublishedAppCount() => select<ProjectsCubit, int?>(
    (cubit) => switch (cubit.state) {
      ProjectsLoaded(:final all) => all.length,
      _ => null,
    },
  );
}

/// Fills the `{appCount}` placeholder in content strings.
extension AppCountTemplateX on String {
  /// Replaces every `{appCount}` with [count].
  String withAppCount(String count) => replaceAll('{$appCountArg}', count);
}
