import 'package:clever_portfolio/core/abstract/base_cubit.dart';
import 'package:clever_portfolio/features/contact/domain/entities/contact_message.dart';
import 'package:clever_portfolio/features/contact/domain/usecases/send_message.dart';
import 'package:clever_portfolio/features/contact/presentation/cubit/contact_state.dart';
import 'package:injectable/injectable.dart';

/// Drives the contact-form lifecycle (plan.md §5.4).
@injectable
class ContactCubit extends BaseCubit<ContactState> {
  /// Creates the cubit.
  ContactCubit(this._sendMessage) : super(const ContactState.idle());

  final SendMessage _sendMessage;

  /// Validates + submits [message].
  Future<void> submit(ContactMessage message) async {
    emit(const ContactState.submitting());
    final result = await _sendMessage(message);
    result.fold(
      (failure) => emit(ContactState.failure(failure)),
      (_) => emit(const ContactState.success()),
    );
  }

  /// Resets to idle (e.g. after showing an error).
  void reset() => emit(const ContactState.idle());
}
