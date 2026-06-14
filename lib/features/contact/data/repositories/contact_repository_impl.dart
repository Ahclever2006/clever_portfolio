import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/core/network/api_endpoints.dart';
import 'package:clever_portfolio/core/network/dio_client.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/contact/domain/entities/contact_message.dart';
import 'package:clever_portfolio/features/contact/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Posts the message via [DioClient] when a backend is configured; otherwise
/// short-circuits to a graceful failure (the UI offers a `mailto:` fallback).
@LazySingleton(as: ContactRepository)
class ContactRepositoryImpl implements ContactRepository {
  /// Creates the impl over a [DioClient].
  const ContactRepositoryImpl(this._client);

  final DioClient _client;

  @override
  ResultVoid send(ContactMessage message) {
    if (!ApiEndpoints.hasRemote) {
      return Future.value(
        const Left(ServerFailure(message: 'Contact endpoint not configured.')),
      );
    }
    return _client.post(
      ApiEndpoints.contact,
      body: {
        'name': message.name,
        'email': message.email,
        'message': message.message,
      },
    );
  }
}
