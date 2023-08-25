import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapControllerUtils {
  /// othe variables
  late LatLng currentLocation;

  /// default values
  double defaultZoom = 15.5;

  /// map variables
  MapController mapController = MapController();
  late AnimationController positionAnimationController;
  AnimationController? rotationAnimationController;
  late TickerProvider tickerProvider;

  ///
  bool checkIfMapLocationIsEqualToCurrentLocation() {
    if (currentLocation.latitude == mapController.center.latitude &&
        mapController.center.longitude == currentLocation.longitude) {
      return true;
    }
    return false;
  }

  void animatedMapMove(LatLng destLocation, double destZoom) async {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    /// initializing Controller
    positionAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: tickerProvider);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    final Animation<double> animation = CurvedAnimation(
        parent: positionAnimationController, curve: Curves.fastOutSlowIn);

    positionAnimationController.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        positionAnimationController.dispose();
      }
    });

    await positionAnimationController.forward();
  }

  void animatToCurrentLocation({double? zoom}) async {
    ///Tweens for each variable
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: currentLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: currentLocation.longitude);
    final zoomTween =
        Tween<double>(begin: mapController.zoom, end: zoom ?? defaultZoom);

    /// initializing Controller
    positionAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: tickerProvider);

    /// defining animtion
    final Animation<double> animation = CurvedAnimation(
        parent: positionAnimationController, curve: Curves.fastOutSlowIn);

    positionAnimationController.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        positionAnimationController.dispose();
      }
    });

    await positionAnimationController.forward();
  }

  void animatAndRotateLocation(double rotate) async {
    ///Tweens for each variable
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: currentLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: currentLocation.longitude);
    final rotateTween =
        Tween<double>(begin: mapController.rotation, end: rotate);

    /// initializing Controller
    positionAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: tickerProvider);

    /// defining animtion
    final Animation<double> animation = CurvedAnimation(
        parent: positionAnimationController, curve: Curves.fastOutSlowIn);

    positionAnimationController.addListener(() {
      mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          rotateTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        positionAnimationController.dispose();
      }
    });

    await positionAnimationController.forward();
  }

  void animateRotation(double rotate) async {
    ///Tweens for each variable
    final rotateTween =
        Tween<double>(begin: mapController.rotation, end: rotate);

    /// initializing Controller
    rotationAnimationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: tickerProvider);

    /// defining animtion
    final Animation<double> animation = CurvedAnimation(
        parent: rotationAnimationController!, curve: Curves.fastOutSlowIn);

    rotationAnimationController!.addListener(() {
      mapController.rotate(rotateTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        rotationAnimationController!.dispose();
      }
    });

    await rotationAnimationController!.forward();
  }
}
