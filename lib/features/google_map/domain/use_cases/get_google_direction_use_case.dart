import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../data/models/google/get_google_direction_request_model.dart';
import '../../data/models/google/get_google_direction_response_model.dart';
import '../../data/models/mapbox/get_mapbox_direction_request_model.dart';
import '../../data/models/mapbox/get_mapbox_direction_response_model.dart';
import '../../data/repositories/direction_repository.dart';

class GetGoogleDirectionUsecase extends UseCase<GetGoogleDirectionResponseModel,
    GetGoogleDirectionRequestModel> {
  DirectionRepository repository;
  GetGoogleDirectionUsecase(this.repository);

  @override
  Future<Either<Failure, GetGoogleDirectionResponseModel>> call(
      GetGoogleDirectionRequestModel params) async {
    return await repository.getGoogleDirection(params);
  }
}

class GetMapboxDirectionUsecase extends UseCase<GetMapboxDirectionResponseModel,
    GetMapboxDirectionRequestModel> {
  DirectionRepository repository;
  GetMapboxDirectionUsecase(this.repository);

  @override
  Future<Either<Failure, GetMapboxDirectionResponseModel>> call(
      GetMapboxDirectionRequestModel params) async {
    return await repository.getMapboxDirection(params);
  }
}
