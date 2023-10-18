// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart' as latlong2;
import 'dart:math';

class CustomMap extends StatefulWidget {
  const CustomMap({
    Key? key,
    this.width,
    this.height,
    required this.places, // List of places to display on the map
    required this.initialCenter, // Initial center of the map
    required this.markerIcon, // Icon to use for markers
    required this.markerBackgroundColor, // Background color of markers
    required this.clusterTextColor, // Text color for cluster markers
    required this.clusterBackgroundColor, // Background color for cluster markers
    required this.clusterBorderWidth, // Border width for cluster markers
    required this.clusterBorderColor, // Border color for cluster markers
    required this.maxClusterRadius, // Maximum cluster radius
    required this.minClusterSize, // Minimum cluster size
    required this.maxClusterSize, // Maximum cluster size
    required this.initialZoom, // Initial zoom level of the map
    required this.minZoom, // Minimum zoom level
    required this.maxZoom, // Maximum zoom level
    required this.mapboxId, // Mapbox ID for the map style
    required this.mapboxUsername, // Mapbox username
    this.callBackAction, // Callback function to execute on marker tap
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<PlacesRecord> places;
  final LatLng initialCenter;
  final Widget markerIcon;
  final Color markerBackgroundColor;
  final Color clusterTextColor;
  final Color clusterBackgroundColor;
  final double? clusterBorderWidth;
  final Color? clusterBorderColor;
  final int maxClusterRadius;
  final double minClusterSize;
  final double maxClusterSize;
  final double initialZoom;
  final double minZoom;
  final double maxZoom;
  final String mapboxId;
  final String mapboxUsername;
  final Future<dynamic> Function()? callBackAction;

  @override
  _CustomMapState createState() => _CustomMapState();
}

// Class to represent a place with its coordinates and document reference
class PlacesWithDocRef {
  latlong2.LatLng coordinates;
  DocumentReference documentRef;

  PlacesWithDocRef(this.coordinates, this.documentRef);
}

class _CustomMapState extends State<CustomMap> {
  MapController mapController = MapController();
  late List<PlacesWithDocRef> convertedPlacesWithRefs;

  @override
  void initState() {
    // Convert the list of places into a list of PlacesWithDocRef objects
    convertedPlacesWithRefs = widget.places.map<PlacesWithDocRef>((places) {
      return PlacesWithDocRef(
          latlong2.LatLng(places.latLng!.latitude, places.latLng!.longitude),
          places.reference);
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: FlutterMap(
        options: MapOptions(
          center: latlong2.LatLng(
              widget.initialCenter.latitude, widget.initialCenter.longitude),
          zoom: widget.initialZoom,
          maxZoom: widget.maxZoom,
          minZoom: widget.minZoom,
          interactiveFlags: InteractiveFlag.pinchZoom |
              InteractiveFlag.drag |
              InteractiveFlag.doubleTapZoom,
        ),
        children: <Widget>[
          // Tile layer for the map using Mapbox style
          TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/{mapboxUsername}/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: {
                'mapboxUsername': widget.mapboxUsername,
                'accessToken': FFAppState().mapboxToken,
                'id': widget.mapboxId, // Mapbox style ID
              }),
          MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
              // Function to compute cluster marker size based on the number of markers
              computeSize: (markers) {
                var count = markers.length;
                var scaleFactor =
                    (log(count + 1) / log(widget.maxClusterSize + 1));
                var size = widget.minClusterSize +
                    scaleFactor *
                        (widget.maxClusterSize - widget.minClusterSize);
                return Size(size, size);
              },
              maxClusterRadius: widget.maxClusterRadius,
              fitBoundsOptions: FitBoundsOptions(
                padding: EdgeInsets.all(50),
              ),
              markers: convertedPlacesWithRefs
                  .map((pair) => Marker(
                        width: (widget.markerIcon as Icon).size! + 8,
                        height: (widget.markerIcon as Icon).size! + 8,
                        anchorPos: AnchorPos.align(AnchorAlign.center),
                        point: pair.coordinates,
                        builder: (ctx) => GestureDetector(
                          onTap: () {
                            FFAppState().selectedPlace = pair.documentRef;
                            if (widget.callBackAction != null) {
                              widget.callBackAction!();
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.markerBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                (widget.markerIcon as Icon).icon,
                                color: (widget.markerIcon as Icon).color,
                                size: (widget.markerIcon as Icon).size,
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
              polygonOptions: PolygonOptions(
                borderColor: Colors.transparent,
                color: Colors.transparent,
                borderStrokeWidth: 0,
              ),
              builder: (context, markers) {
                var count = markers.length;
                return Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.clusterBackgroundColor,
                    border: widget.clusterBorderWidth != null
                        ? Border.all(
                            width: widget.clusterBorderWidth!,
                            color: widget.clusterBorderColor!)
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      '$count',
                      style: TextStyle(
                        color: widget.clusterTextColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
