import 'package:clever_portfolio/core/error/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_state.freezed.dart';

/// State for [ContactCubit].
@freezed
sealed class ContactState with _$ContactState {
  /// Idle / editing.
  const factory ContactState.idle() = ContactIdle;

  /// Submitting.
  const factory ContactState.submitting() = ContactSubmitting;

  /// Sent successfully.
  const factory ContactState.success() = ContactSuccess;

  /// Submission failed (validation or network).
  const factory ContactState.failure(Failure failure) = ContactFailure;
}
