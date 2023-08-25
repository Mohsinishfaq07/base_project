import 'package:dartz/dartz.dart';
import 'package:sb_myreports/features/jokes/data/models/get_query_jokes_request_model.dart';
import 'package:sb_myreports/features/jokes/data/models/get_query_jokes_response_model.dart';
import 'package:sb_myreports/features/jokes/data/models/get_random_joke_response_model.dart';
import 'package:sb_myreports/features/jokes/domain/repositories/joke_repository.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';

class GetQueryJokesUsecase
    extends UseCase<GetQueryJokesResponseModel, GetQueryJokesRequestModel> {
  JokeRepository repository;
  GetQueryJokesUsecase(this.repository);

  @override
  Future<Either<Failure, GetQueryJokesResponseModel>> call(
      GetQueryJokesRequestModel params) async {
    return await repository.getQueryJokes(params);
  }
}
