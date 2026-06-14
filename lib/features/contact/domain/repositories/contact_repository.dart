import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/contact/domain/entities/contact_message.dart';

/// Sends contact-form messages.
abstract class ContactRepository {
  /// Submits [message] to the configured backend.
  ResultVoid send(ContactMessage message);
}
