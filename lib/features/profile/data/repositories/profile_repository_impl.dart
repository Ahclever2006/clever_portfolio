import 'package:clever_portfolio/core/error/exceptions.dart';
import 'package:clever_portfolio/core/error/failures.dart';
import 'package:clever_portfolio/core/utils/typedefs.dart';
import 'package:clever_portfolio/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:clever_portfolio/features/profile/domain/entities/profile.dart';
import 'package:clever_portfolio/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  /// Creates the impl over a [ProfileLocalDataSource].
  const ProfileRepositoryImpl(this._local);

  final ProfileLocalDataSource _local;

  @override
  ResultFuture<Profile> getProfile() async {
    try {
      return Right((await _local.getProfile()).toEntity());
    } on AssetException catch (e) {
      return Left(AssetFailure(message: e.message));
    }
  }
}
