import 'package:clever_portfolio/core/error/failures.dart';
import 'package:dartz/dartz.dart';

/// `Future<Either<Failure, T>>` — the async result currency (plan.md §5.2).
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// `Future<Either<Failure, Unit>>` — async "void success".
typedef ResultVoid = Future<Either<Failure, Unit>>;

/// Decoded JSON map.
typedef DataMap = Map<String, dynamic>;
