import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/core/network/interceptors/logging_interceptor.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

/// Configured Dio wrapper that returns `Either<Failure, T>` (plan.md §5.3).
///
/// Not used for static content (bundled JSON covers that) — reserved for the
/// one genuine network surface: the contact-form POST + future remote content.
@lazySingleton
class DioClient {
  /// Creates a [DioClient] over an injected [Dio].
  DioClient(this._dio) {
    _dio
      ..options = BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      )
      ..interceptors.add(LoggingInterceptor());
  }

  final Dio _dio;

  /// POSTs [body] to [path], mapping Dio errors to [Failure]s.
  ResultVoid post(String path, {required DataMap body}) async {
    try {
      await _dio.post<dynamic>(path, data: body);
      return const Right(unit);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return const Left(NetworkFailure());
      }
      return Left(
        ServerFailure(
          message: e.message ?? 'Request failed',
          statusCode: e.response?.statusCode,
        ),
      );
    }
  }
}
