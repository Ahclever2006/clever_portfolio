import 'package:clever_portfolio/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Generic async use-case contract (plan.md §5.2). Every async use case is
/// callable and returns `Either<Failure, Output>`.
abstract class UseCase<Output, Params> {
  /// Const base constructor.
  const UseCase();

  /// Executes the use case.
  Future<Either<Failure, Output>> call(Params params);
}

/// Synchronous variant for pure in-memory transforms (e.g. filtering an
/// already-loaded list) where there is no async/IO boundary.
abstract class SyncUseCase<Output, Params> {
  /// Const base constructor.
  const SyncUseCase();

  /// Executes the use case synchronously.
  Either<Failure, Output> call(Params params);
}

/// Sentinel for parameterless use cases (e.g. `GetProjects`, `GetProfile`).
class NoParams extends Equatable {
  /// Creates a [NoParams].
  const NoParams();

  @override
  List<Object?> get props => const [];
}
