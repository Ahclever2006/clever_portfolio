// Typed exceptions thrown by data sources; repositories catch these and map
// them to Failures (plan.md §5.3). Throw these instead of generic `Exception`
// so failure handling can pattern-match.

/// Thrown when a bundled asset / JSON cannot be loaded or parsed.
class AssetException implements Exception {
  /// Creates an [AssetException].
  const AssetException(this.message, [this.stackTrace]);

  /// Description of what failed.
  final String message;

  /// Originating stack trace, when available.
  final StackTrace? stackTrace;

  @override
  String toString() => 'AssetException: $message';
}

/// Thrown on local-storage (SharedPreferences) errors.
class CacheException implements Exception {
  /// Creates a [CacheException].
  const CacheException(this.message);

  /// Description of what failed.
  final String message;

  @override
  String toString() => 'CacheException: $message';
}

/// Thrown on remote (Dio) errors.
class ServerException implements Exception {
  /// Creates a [ServerException] with an optional [statusCode].
  const ServerException(this.message, [this.statusCode]);

  /// Description of what failed.
  final String message;

  /// HTTP status code, when available.
  final int? statusCode;

  @override
  String toString() => 'ServerException($statusCode): $message';
}
