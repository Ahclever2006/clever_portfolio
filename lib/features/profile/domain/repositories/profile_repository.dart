import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';

/// Source of the profile / CV.
abstract class ProfileRepository {
  /// Loads the profile.
  ResultFuture<Profile> getProfile();
}
