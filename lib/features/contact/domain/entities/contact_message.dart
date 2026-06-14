import 'package:equatable/equatable.dart';

/// A contact-form submission (plan.md §5.3).
class ContactMessage extends Equatable {
  /// Creates a [ContactMessage].
  const ContactMessage({
    required this.name,
    required this.email,
    required this.message,
  });

  /// Sender name.
  final String name;

  /// Sender email.
  final String email;

  /// Message body.
  final String message;

  @override
  List<Object?> get props => [name, email, message];
}
