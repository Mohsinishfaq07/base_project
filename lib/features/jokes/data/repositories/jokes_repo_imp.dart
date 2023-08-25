import 'package:dartz/dartz.dart';
import 'package:sb_myreports/core/usecases/usecase.dart';
import 'package:sb_myreports/features/jokes/data/models/get_query_jokes_request_model.dart';
import 'package:sb_myreports/features/jokes/data/models/get_random_joke_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/network/network_info.dart';
import '../../../authentication/login/data/modals/login_response_modal.dart';
import '../../domain/repositories/joke_repository.dart';
import '../data_sources/joke_remote_data_source.dart';
import '../models/get_query_jokes_response_model.dart';

class JokesRepoImp extends JokeRepository {
  final NetworkInfo networkInfo;

  final JokesRemoteDataSource remoteDataSource;

  JokesRepoImp({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, GetRandomJokeResponseModel>> getRandomJoke(
      NoParams params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getRandomJoke(params));
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetQueryJokesResponseModel>> getQueryJokes(
      GetQueryJokesRequestModel params) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure(AppMessages.noInternet));
    }
    try {
      return Right(await remoteDataSource.getQueryJokes(params));
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
