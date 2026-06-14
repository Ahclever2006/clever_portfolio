import 'package:equatable/equatable.dart';

/// Sealed failure root so exhaustive `switch` in the UI is analyzer-enforced
/// (plan.md §5.2). Repositories convert thrown exceptions into these.
sealed class Failure extends Equatable {
  /// Creates a failure with a human-readable [message].
  const Failure({required this.message});

  /// Human-readable description.
  final String message;

  @override
  List<Object?> get props => [message];
}

/// Local asset / bundled-JSON load or parse failure.
final class AssetFailure extends Failure {
  /// Creates an [AssetFailure].
  const AssetFailure({super.message = 'Could not load local content.'});
}

/// SharedPreferences (or other local storage) failure.
final class CacheFailure extends Failure {
  /// Creates a [CacheFailure].
  const CacheFailure({super.message = 'Local storage error.'});
}

/// Remote (Dio) failure, e.g. the contact-form POST.
final class ServerFailure extends Failure {
  /// Creates a [ServerFailure] with an optional [statusCode].
  const ServerFailure({required super.message, this.statusCode});

  /// HTTP status code, when available.
  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

/// No connectivity when a network call was attempted.
final class NetworkFailure extends Failure {
  /// Creates a [NetworkFailure].
  const NetworkFailure({super.message = 'No internet connection.'});
}

/// Client-side validation failure (e.g. contact form).
final class ValidationFailure extends Failure {
  /// Creates a [ValidationFailure].
  const ValidationFailure({required super.message});
}
