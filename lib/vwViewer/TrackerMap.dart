import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackerMap extends StatefulWidget {
  @override
  _TrackerMapState createState() => _TrackerMapState();
}

class _TrackerMapState extends State<TrackerMap> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _myLocation = CameraPosition(
    target: LatLng(13.067439, 80.237617),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _myLocation,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
