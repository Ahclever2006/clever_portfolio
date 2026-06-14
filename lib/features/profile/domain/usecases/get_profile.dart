import 'package:clever_portfolio/core/usecase/usecase.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';
import 'package:clever_portfolio/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

/// Loads the profile / CV.
@injectable
class GetProfile extends UseCase<Profile, NoParams> {
  /// Creates the use case.
  const GetProfile(this._repository);

  final ProfileRepository _repository;

  @override
  ResultFuture<Profile> call(NoParams params) => _repository.getProfile();
}
