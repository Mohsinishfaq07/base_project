// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:latlong2/latlong.dart';
import 'package:sb_myreports/core/utils/enums/vehicle_type_enum.dart';

class GetGoogleDirectionRequestModel {
  final LatLng source;
  final LatLng destination;
  final VehicleType vehicleType;
  GetGoogleDirectionRequestModel({
    required this.source,
    required this.destination,
    required this.vehicleType,
  });
}
