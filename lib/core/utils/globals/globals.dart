import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GlobalKey<NavigatorState> navigatorKeyGlobal = GlobalKey<NavigatorState>();
final sl = GetIt.instance;
// Google api,s key
String googleApiKey = "AIzaSyDtBoDqh6Vr0qg9q9iKLotrmq19d67rBj8";
String mapboxApiToken =
    "pk.eyJ1IjoiZGV2YWlzcHJvamVjdHMiLCJhIjoiY2xicDFvaTJ5MDBjdzN1cXQxM2dyeHp6aiJ9.JOYTjGshZEnAHRrCMAi4Rg";

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();
