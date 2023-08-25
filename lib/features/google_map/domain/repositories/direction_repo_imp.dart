import 'package:dartz/dartz.dart';
import 'package:sb_myreports/features/google_map/data/models/mapbox/get_mapbox_direction_response_model.dart';
import 'package:sb_myreports/features/google_map/data/models/mapbox/get_mapbox_direction_request_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/network/network_info.dart';
import '../../data/data_sources/direction_remote_data_source.dart';
import '../../data/models/google/get_google_direction_request_model.dart';
import '../../data/models/google/get_google_direction_response_model.dart';
import '../../data/repositories/direction_repository.dart';

class DirectionRepoImp extends DirectionRepository {
  final NetworkInfo networkInfo;

  final DirectionRemoteDataSource remoteDataSource;

  DirectionRepoImp({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, GetGoogleDirectionResponseModel>> getGoogleDirection(
      GetGoogleDirectionRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getGoogleDirection(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetMapboxDirectionResponseModel>> getMapboxDirection(
      GetMapboxDirectionRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getMapboxDirection(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }
}

/// Status codes
/// 200
/// 400, 500
