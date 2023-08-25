import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;
import 'package:location/location.dart';
import 'package:sb_myreports/core/utils/enums/vehicle_type_enum.dart';
import 'package:sb_myreports/core/utils/flutter_map/flutter_map_utils.dart';
import 'package:sb_myreports/core/utils/google_map/polyLines.dart';
import 'package:sb_myreports/core/utils/location/location.dart';
import 'package:sb_myreports/features/google_map/data/models/google/get_query_place_request_model.dart';
import 'package:sb_myreports/features/google_map/data/models/google/get_query_place_response_model.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/globals/snack_bar.dart';
import '../../../../core/utils/flutter_map/map_markers.dart';
import '../../data/models/google/get_google_direction_request_model.dart';
import '../../data/models/google/get_google_direction_response_model.dart';
import '../../domain/use_cases/get_google_direction_use_case.dart';
import '../../domain/use_cases/get_query_place.dart';
import 'package:latlong2/latlong.dart';

class MapProvider extends ChangeNotifier {
  MapProvider(this._getQueryPlaceUsecase, this._getGoogleDirectionUsecase);

  /// variables
  FlutterMapControllerUtils mapUtils = FlutterMapControllerUtils();
  GetGoogleDirectionResponseModel? directionModel;
  // GetMapboxDirectionResponseModel? directionModel;
  bool isGettinLabels = false;
  bool isSettingRotaion = false;
  // double compassRotation = 0;
  List<LatLng>? polylinePoints;
  List<PlaceResult> locationsSearched = [];

  /// for example of the user and the destination point
  Set<Marker> locationMarkers = {};

  /// contains info about the road he is going to follow
  Set<Marker> labelMarkers = {};

  /// Utils
  final LocationImp _locationImp = LocationImp();
  final PolyLineInfoImp _polyLinesImp = PolyLineInfoImp();

  /// UserCases
  final GetQueryPlaceUsecase _getQueryPlaceUsecase;
  final GetGoogleDirectionUsecase _getGoogleDirectionUsecase;
  // final GetMapboxDirectionUsecase _getMapboxDirectionUsecase;

  /// Streams Subscription
  StreamSubscription<LocationData>? locationStream;
  StreamSubscription<CompassEvent>? mobileCompassStream;

  //valuenotifiers
  ValueNotifier<LatLng?> currentLocation = ValueNotifier(null);
  ValueNotifier<LatLng?> destinationLocation = ValueNotifier(null);

  /// loaders
  ValueNotifier<bool> isBusy = ValueNotifier(false);
  ValueNotifier<bool> placeLoading = ValueNotifier(false);
  // ValueNotifier<bool> polyLinesLoading = ValueNotifier(false);

  /// methods

  Future<void> getLocationOnce() async {
    isBusy.value = true;
    LocationData data = await _locationImp.getLocation();

    currentLocation.value = LatLng(data.latitude!, data.longitude!);
    mapUtils.currentLocation = currentLocation.value!;
    locationMarkers
        .add(MapMarkers.currentLocationMaker(currentLocation.value!));
    mapUtils.animatToCurrentLocation();
    isBusy.value = false;
    notifyListeners();
  }

  /// will keep on listening to location stream unless
  /// destination is reached or user cancels the ride
  Future<void> getLocationStream() async {
    polylinePoints = [];
    locationStream = _locationImp.getLocationStream().listen((data) {
      currentLocation.value = LatLng(data.latitude!, data.longitude!);
    });
  }

  //usecases calls
  Future<void> getQueryPlace(String query) async {
    locationsSearched = [];
    placeLoading.value = true;
    final params = GetQueryPlaceRequestModel(query: query);
    var loginEither = await _getQueryPlaceUsecase(params);
    if (loginEither.isLeft()) {
      handleError(loginEither);
      placeLoading.value = false;
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, previous) async {
        if (response.status == "OK") {
          {
            if (response.results!.isNotEmpty) {
              for (var i = 0; i < response.results!.length; i++) {
                locationsSearched.add(response.results![i]);
              }
            }
            placeLoading.value = false;
          }
        }
      });
    }
  }

  Future<void> getDirection() async {
    locationsSearched = [];
    placeLoading.value = true;
    final params = GetGoogleDirectionRequestModel(
      source: currentLocation.value!,
      destination: destinationLocation.value!,

      ///Todo: make variable global
      vehicleType: VehicleType.private,
    );

    var loginEither = await _getGoogleDirectionUsecase(params);
    if (loginEither.isLeft()) {
      handleError(loginEither);
    } else if (loginEither.isRight()) {
      loginEither.foldRight(null, (response, previous) async {
        directionModel = response;
        // Logger().i(response.toJson());
      });
    }
  }

  /// gets all the points from source to destination location
  /// and draws polyline on map
  void drawPolyLinesForDestination(
    PlaceResult destination,
    /* GoogleMapController mapCont*/
  ) async {
    isBusy.value = true;
    var locate = destination.geometry!.location!;
    destinationLocation.value = LatLng(locate.lat!, locate.lng!);
    await getDirection();
    locationMarkers
        .add(MapMarkers.destinationLocationMaker(destinationLocation.value!));
    polylinePoints = _polyLinesImp.getPolyLineCoordinatesFromEncodedString(
        directionModel!.routes!.first.overviewPolyline!.points!);
    // await getLabels(13.5);
    addRotationListner();
    // await mapUtils.resetPostion(tiltCamera: !mapUtils.isCameraTilted);
    isBusy.value = false;
    notifyListeners();
  }

  ///
  Future<void> getLabels(double zoomValue) async {
    if (!isGettinLabels) {
      removeAllMarkersExceptSourceDestination(shouldNotify: false);
      isGettinLabels = true;
      // print((25 - (zoomValue).toInt()));
      List<Steps> steps = directionModel!.routes!.first.legs!.first.steps ?? [];
      for (var i = 0; i < steps.length; i++) {
        /// modify formula
        List<String> roadName = steps[i].htmlInstructions!.split("em\">");
        labelMarkers.add(MapMarkers.labelMaker(
          "Point $i",
          LatLng(steps[i].startLocation!.lat!, steps[i].startLocation!.lng!),
        ));
      }
      // print(mapMarkers.length);
      isGettinLabels = false;
      notifyListeners();
    }
  }

  /// starts listening to mobile rotation changes
  void addRotationListner() {
    mobileCompassStream = FlutterCompass.events!.listen((event) async {
      if (!isSettingRotaion) {
        isSettingRotaion = true;
        // await Future.delayed(const Duration(milliseconds: 1000));
        if (mapUtils.checkIfMapLocationIsEqualToCurrentLocation()) {
          mapUtils.animateRotation(event.heading ?? 0);
        }
        isSettingRotaion = false;
      }
    });
  }

  ///
  void removeAllMarkersExceptSourceDestination({bool shouldNotify = true}) {
    labelMarkers.clear();
    if (shouldNotify) {
      notifyListeners();
    }
  }

  void onMapTypeChange(int value) {
    // mapUtils.selectedMap = value;
    notifyListeners();
  }

  /// resets destinationLocation and
  /// polylines
  void cancelNavigation() {
    if (mobileCompassStream != null) {
      mobileCompassStream!.cancel();
    }
    labelMarkers.clear();
    locationMarkers = {locationMarkers.first};
    destinationLocation.value = null;
    polylinePoints = null;
    notifyListeners();
  }

  // Error Handling
  void handleError(Either<Failure, dynamic> either) {
    either.fold((l) => ShowSnackBar.show(l.message), (r) => null);
  }

  void addMarker() {
    locationMarkers.add(MapMarkers.destinationLocationMaker(polylinePoints![0],
        color: Colors.green));
    notifyListeners();
  }

  @override
  void dispose() {
    if (locationStream != null) {
      locationStream!.cancel();
    }
    if (mobileCompassStream != null) {
      mobileCompassStream!.cancel();
    }
    super.dispose();
  }
}
