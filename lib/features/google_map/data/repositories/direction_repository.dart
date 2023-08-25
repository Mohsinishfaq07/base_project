import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/google/get_google_direction_request_model.dart';
import '../models/google/get_google_direction_response_model.dart';
import '../models/mapbox/get_mapbox_direction_request_model.dart';
import '../models/mapbox/get_mapbox_direction_response_model.dart';

abstract class DirectionRepository {
  Future<Either<Failure, GetGoogleDirectionResponseModel>> getGoogleDirection(
      GetGoogleDirectionRequestModel params);
  Future<Either<Failure, GetMapboxDirectionResponseModel>> getMapboxDirection(
      GetMapboxDirectionRequestModel params);
}
