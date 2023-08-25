import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sb_myreports/core/utils/globals/globals.dart';
import 'package:sb_myreports/core/utils/helper/vehicle_type_to_travel_mode.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/modals/error_response_model.dart';
import '../../../../core/utils/constants/app_messages.dart';
import '../../../../core/utils/constants/app_url.dart';
import '../models/google/get_google_direction_request_model.dart';
import '../models/google/get_google_direction_response_model.dart';
import '../models/mapbox/get_mapbox_direction_request_model.dart';
import '../models/mapbox/get_mapbox_direction_response_model.dart';

abstract class DirectionRemoteDataSource {
  Future<GetGoogleDirectionResponseModel> getGoogleDirection(
      GetGoogleDirectionRequestModel params);
  Future<GetMapboxDirectionResponseModel> getMapboxDirection(
      GetMapboxDirectionRequestModel params);
}

class DirectionRemoteDataSourceImp implements DirectionRemoteDataSource {
  Dio dio;
  DirectionRemoteDataSourceImp({required this.dio});

  @override
  Future<GetGoogleDirectionResponseModel> getGoogleDirection(
      GetGoogleDirectionRequestModel params) async {
    String url = AppUrl.googleApisBaseUrl +
        AppUrl.googleDirectionApiUrl +
        'origin=${params.source.latitude},${params.source.longitude}' +
        '&destination=${params.destination.latitude},${params.destination.longitude}' +
        "&travelMode=${vehicleTypeToGoogleTravelMode(params.vehicleType)}" +
        "&key=" +
        googleApiKey;
    print(url);
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        var object = GetGoogleDirectionResponseModel.fromJson(response.data);

        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel.fromJson(exception.response?.data);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }

  @override
  Future<GetMapboxDirectionResponseModel> getMapboxDirection(
      GetMapboxDirectionRequestModel params) async {
    String url = AppUrl.mapboxApiBaseUrl +
        AppUrl.mapboxDirectionApiUrl +

        /// remove if issue persists
        "${vehicleTypeToMapboxTravelMode(params.vehicleType)}/"
            '${params.source.longitude},${params.source.latitude};' +
        '${params.destination.longitude},${params.destination.latitude}' +
        AppUrl.mapboxDirectionApiEndUrl +
        "&access_token=" +
        mapboxApiToken;
    print(url);
    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        var object = GetMapboxDirectionResponseModel.fromJson(response.data);

        return object;
      }

      throw const SomethingWentWrong(AppMessages.somethingWentWrong);
    } on DioError catch (exception) {
      Logger().i('returning error');
      if (exception.type == DioErrorType.connectTimeout) {
        throw TimeoutException(AppMessages.timeOut);
      } else {
        ErrorResponseModel errorResponseModel =
            ErrorResponseModel.fromJson(exception.response?.data);
        throw SomethingWentWrong(errorResponseModel.msg);
      }
    } catch (e) {
      throw SomethingWentWrong(e.toString());
    }
  }
}
