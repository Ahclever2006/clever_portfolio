import 'package:flutter_bloc/flutter_bloc.dart';

/// Base class for every Cubit in the app.
///
/// Guards [emit] against being called after the cubit is closed — a common
/// source of "emit after close" errors when async work resolves late. All
/// feature cubits must extend this instead of [Cubit] directly (house rule).
abstract class BaseCubit<T> extends Cubit<T> {
  /// Creates a [BaseCubit] seeded with [initialState].
  BaseCubit(super.initialState);

  @override
  void emit(T state) {
    if (!isClosed) super.emit(state);
  }
}
