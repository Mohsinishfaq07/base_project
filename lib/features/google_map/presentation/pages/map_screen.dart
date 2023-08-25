import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:sb_myreports/core/utils/flutter_map/map_tile_layers_list.dart';
import 'package:sb_myreports/core/utils/google_map/custom_map_markers.dart';
import 'package:sb_myreports/features/google_map/presentation/manager/map_provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:sb_myreports/core/utils/constants/app_assets.dart';

import '../../../../core/utils/globals/globals.dart';
import '../../data/models/google/get_query_place_response_model.dart';

import '../widgets/custom_search_delegate.dart';
import 'package:latlong2/latlong.dart';
import '../../data/models/google/get_google_direction_response_model.dart'
    as drm;

class GoogleMapScreen extends StatelessWidget {
  GoogleMapScreen({Key? key}) : super(key: key);
  MapProvider mapProvider = sl();
  // Provider state managements

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: mapProvider, child: const GoogleMapScreenContent());
  }
}

class GoogleMapScreenContent extends StatefulWidget {
  const GoogleMapScreenContent({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreenContent> createState() => _GoogleMapScreenContentState();
}

class _GoogleMapScreenContentState extends State<GoogleMapScreenContent>
    with TickerProviderStateMixin {
  late AnimationController mapAnimationController;
  final PanelController panelController = PanelController();
  int mapTypeIndex = 0;
  // camera position on scroll
  double previousZoom = 0;
  MapProvider mapProvider = sl();
  @override
  void initState() {
    super.initState();

    context.read<MapProvider>().mapUtils.tickerProvider = this;
    context.read<MapProvider>().getLocationOnce();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await MapMarkers.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: floatingActionButton(),
      appBar: appbar(),
      body: Consumer<MapProvider>(builder: (context, provider, child) {
        // if (provider.currentLocationLoading.value) {
        //   return const Center(child: CircularProgressIndicator.adaptive());
        // }
        return SlidingUpPanel(
            minHeight: 20,
            maxHeight: 450,
            isDraggable: mapProvider.destinationLocation.value != null,
            // backdropColor: Colors.transparent,
            color: Colors.transparent,
            controller: panelController,
            panel: Directionsbottomsheet(mapProvider: mapProvider),
            body: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    zoom: 5,
                    maxZoom: 18.4,
                  ),
                  mapController: provider.mapUtils.mapController,
                  children: [
                    TileLayer(
                      urlTemplate: mapTilesList[mapTypeIndex],
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    CircleLayer(
                      circles: [
                        if (provider.currentLocation.value != null)
                          CircleMarker(
                            point: provider.currentLocation.value!,
                            radius: 80,
                            useRadiusInMeter: true,
                            borderColor: Colors.blue.withOpacity(0.5),
                            borderStrokeWidth: 2,
                            color: Colors.blue.withOpacity(0.2),
                          )
                      ],
                    ),
                    if (provider.polylinePoints != null)
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: provider.polylinePoints!,
                            color: Colors.red,
                            strokeWidth: 8,
                            strokeJoin: StrokeJoin.miter,
                            colorsStop: [0, 1],
                            gradientColors: [Colors.red, Colors.green],
                          ),
                          // Polyline(points: [
                          //   LatLng(33.617407, 73.167674),
                          //   LatLng(33.657851, 73.158515),
                          // ])
                        ],
                      ),
                    MarkerLayer(markers: [
                      ...provider.locationMarkers,
                      ...provider.labelMarkers,
                    ]),
                  ],
                ),

                /// map current location
                Positioned(
                  right: 15,
                  top: 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: GestureDetector(
                      onTap: () {
                        /// while ondrive
                        if (provider.destinationLocation.value != null) {
                          return provider.mapUtils
                              .animatToCurrentLocation(zoom: 18);
                        }
                        provider.mapUtils.animatToCurrentLocation();
                      },
                      child: const ColoredBox(
                        color: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.my_location)),
                      ),
                    ),
                  ),
                ),

                /// map type
                Positioned(
                  right: 15,
                  top: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: GestureDetector(
                      onTap: () => setState(() {
                        setMapType();
                      }),
                      child: const ColoredBox(
                        color: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.map)),
                      ),
                    ),
                  ),
                ),

                if (provider.destinationLocation.value != null)

                  /// Add marker at current location
                  Positioned(
                    right: 15,
                    top: 125,
                    child: Tooltip(
                      message: "Add Marker",
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: GestureDetector(
                          onTap: () => provider.addMarker(),
                          child: const ColoredBox(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.add)),
                          ),
                        ),
                      ),
                    ),
                  ),

                ValueListenableBuilder<bool>(
                  valueListenable: provider.isBusy,
                  builder: (context, value, child) {
                    if (value) {
                      return Center(
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const CircularProgressIndicator.adaptive()),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ));
      }),
    ));
  }

  /// functions

  /// widgets
  Widget floatingActionButton() {
    return ValueListenableBuilder<LatLng?>(
      valueListenable: mapProvider.destinationLocation,
      builder: (context, value, child) => value == null
          ? const SizedBox()
          : FloatingActionButton.extended(
              label: Text(
                "Cancel",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              onPressed: () async {
                mapProvider.cancelNavigation();
                await panelController.close();
                // await mapProvider.mapUtils.resetPostion();
              },
            ),
    );
  }

  PreferredSize appbar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 50),
      child: AppBar(
          toolbarHeight: 50,
          title: GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Search Here",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.black),
              ),
            ),
            onTap: () async {
              var result = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
              if (result is PlaceResult) {
                mapProvider.drawPolyLinesForDestination(result);
              }
            },
          )),
    );
  }

  void setMapType() {
    if (mapTypeIndex == 0) {
      mapTypeIndex = 1;
    } else if (mapTypeIndex == 1) {
      mapTypeIndex = 2;
    } else {
      mapTypeIndex = 0;
    }
    setState(() {});
  }
}

class Directionsbottomsheet extends StatelessWidget {
  const Directionsbottomsheet({
    Key? key,
    required this.mapProvider,
  }) : super(key: key);

  final MapProvider mapProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          alignment: Alignment.center,
          child: const Icon(Icons.more_horiz),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        const Divider(),
        ValueListenableBuilder<LatLng?>(
            valueListenable: mapProvider.destinationLocation,
            builder: (context, value, child) {
              if (value == null || mapProvider.directionModel == null) {
                return const SizedBox();
              } else {
                List<drm.Steps>? steps =
                    mapProvider.directionModel!.routes!.first.legs!.first.steps;
                return SizedBox(
                  height: 400,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: steps!.length,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      itemBuilder: (context, index) {
                        if (steps[index].maneuver != null &&
                            steps[index].distance?.text != null) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                color: Colors.white,
                                // margin: const EdgeInsets.only(bottom: 15),
                                child: ListTile(
                                  tileColor: Colors.white,
                                  title: Text(steps[index].maneuver! +
                                      " (${steps[index].duration!.text!})"),
                                  trailing: Text(steps[index].distance!.text!),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                );
              }
            }),
      ],
    );
  }
}
