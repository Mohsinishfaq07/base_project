import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapMarkers {
  static Marker currentLocationMaker(LatLng location, {Function()? onTap}) {
    return Marker(
      rotate: true,
      builder: (context) => GestureDetector(
        onTap: onTap,
        child: const Icon(
          Icons.location_on,
          color: Colors.blue,
        ),
      ),
      point: location,
    );
  }

  static Marker destinationLocationMaker(LatLng location,
      {Function()? onTap, Color color = Colors.red}) {
    return Marker(
      rotate: true,
      builder: (context) => GestureDetector(
        onTap: onTap,
        child: Icon(
          Icons.location_on,
          color: color,
        ),
      ),
      point: location,
    );
  }

  static Marker labelMaker(String title, LatLng location, {Function()? onTap}) {
    return Marker(
      rotate: true,
      anchorPos: AnchorPos.exactly(Anchor(40, 0)),
      width: 100,
      builder: (context) => GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
      point: location,
    );
  }
}
