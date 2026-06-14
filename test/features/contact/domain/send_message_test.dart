import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/features/contact/domain/entities/contact_message.dart';
import 'package:clever_portfolio/features/contact/domain/repositories/contact_repository.dart';
import 'package:clever_portfolio/features/contact/domain/usecases/send_message.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements ContactRepository {}

void main() {
  late _MockRepo repo;
  late SendMessage useCase;

  setUpAll(
    () => registerFallbackValue(
      const ContactMessage(name: '', email: '', message: ''),
    ),
  );
  setUp(() {
    repo = _MockRepo();
    useCase = SendMessage(repo);
  });

  test('invalid email -> ValidationFailure, repo not called', () async {
    final result = await useCase(
      const ContactMessage(name: 'A', email: 'bad', message: 'hi'),
    );
    result.fold(
      (f) => expect(f, isA<ValidationFailure>()),
      (_) => fail('expected Left'),
    );
    verifyNever(() => repo.send(any()));
  });

  test('blank name -> ValidationFailure', () async {
    final result = await useCase(
      const ContactMessage(name: '   ', email: 'a@b.com', message: 'hi'),
    );
    result.fold(
      (f) => expect(f, isA<ValidationFailure>()),
      (_) => fail('expected Left'),
    );
  });

  test('valid message delegates to repository', () async {
    when(() => repo.send(any())).thenAnswer((_) async => const Right(unit));
    final result = await useCase(
      const ContactMessage(name: 'A', email: 'a@b.com', message: 'hi'),
    );
    expect(result.isRight(), isTrue);
    verify(() => repo.send(any())).called(1);
  });
}
