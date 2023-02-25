import 'dart:async';

import 'package:demo0/src/constants/asset.dart';
import 'package:demo0/src/services/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const CameraPosition _initMap = CameraPosition(
    target: LatLng(13.7462463, 100.5325515),
    zoom: 15,
  );

  static const CameraPosition _newLocation = CameraPosition(
    target: LatLng(13.7443267, 100.5634739),
    zoom: 20,
  );

  final Completer<GoogleMapController> _controller = Completer();
  StreamSubscription<LocationData>? _locationSubscription;
  final _locationService = Location();
  final Set<Marker> _markers = {};
  final Set<Polygon> _polygons = {};

  final List<LatLng> _dummyLatLng = [
    LatLng(13.729336912458525, 100.57422749698162),
    LatLng(13.724325366482798, 100.58511726558208),
    LatLng(13.716931129483003, 100.57489234954119),
    LatLng(13.724794053328308, 100.56783076375723),
  ];

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    _loadMarker();
  }

  Future<void> _loadMarker() async {
    // make map marker
    final Uint8List markerIcon = await getBytesFromAsset(
      Asset.pinSwuImage,
      width: 150,
    );

    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    final marker = Marker(
      icon: bitmap,
      markerId: MarkerId("1234"),
      position: _initMap.target,
    );
    _markers.add(marker);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mappage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.future.then(
          (mapController) => mapController.animateCamera(
            CameraUpdate.newLatLngZoom(_newLocation.target, 20),
          ),
        ),
        child: Icon(Icons.pin_drop),
      ),
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.hybrid,
        initialCameraPosition: _initMap,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
