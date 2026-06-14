import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/contact/domain/entities/contact_message.dart';
import 'package:clever_portfolio/features/contact/domain/repositories/contact_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

/// Validates a [ContactMessage] in-domain, then delegates to the repository.
@injectable
class SendMessage extends UseCase<Unit, ContactMessage> {
  /// Creates the use case.
  const SendMessage(this._repository);

  final ContactRepository _repository;

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  ResultVoid call(ContactMessage params) async {
    if (params.name.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'Name is required.'));
    }
    if (!_emailRegex.hasMatch(params.email.trim())) {
      return const Left(ValidationFailure(message: 'Enter a valid email.'));
    }
    if (params.message.trim().isEmpty) {
      return const Left(ValidationFailure(message: 'Message is required.'));
    }
    return _repository.send(params);
  }
}
