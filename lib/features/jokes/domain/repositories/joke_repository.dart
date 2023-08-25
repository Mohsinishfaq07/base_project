import 'package:dartz/dartz.dart';
import 'package:sb_myreports/core/usecases/usecase.dart';
import 'package:sb_myreports/features/jokes/data/models/get_query_jokes_request_model.dart';
import 'package:sb_myreports/features/jokes/data/models/get_query_jokes_response_model.dart';
import 'package:sb_myreports/features/jokes/data/models/get_random_joke_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class JokeRepository {

  Future<Either<Failure, GetRandomJokeResponseModel>> getRandomJoke(NoParams params);

  Future<Either<Failure, GetQueryJokesResponseModel>> getQueryJokes(GetQueryJokesRequestModel params);


}
