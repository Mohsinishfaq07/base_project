import 'package:sb_myreports/core/utils/enums/vehicle_type_enum.dart';

/// converts enum to travel mode for their respective Apis
String vehicleTypeToGoogleTravelMode(VehicleType vType) {
  switch (vType) {
    case VehicleType.motorcycle:
      return "motorcycle";
    case VehicleType.taxi:
      return "ride";
    case VehicleType.private:
      return "driving";
    default:
      return "driving";
  }
}

/// converts enum to travel mode for their respective Apis
String vehicleTypeToMapboxTravelMode(VehicleType vType) {
  switch (vType) {
    case VehicleType.motorcycle:
      return "cycling";
    case VehicleType.taxi:
      return "driving";
    case VehicleType.private:
      return "driving";
    default:
      return "driving";
  }
}
