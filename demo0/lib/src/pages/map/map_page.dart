import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:demo0/src/app.dart';
import 'package:demo0/src/constants/asset.dart';
import 'package:demo0/src/services/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

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
    _buildSingleMarker(position: LatLng(13.7462463, 100.5325515));
  }

  String formatPosition(LatLng pos) {
    final lat = formatCurrency.format(pos.latitude);
    final lng = formatCurrency.format(pos.longitude);
    return ": $lat, $lng";
  }

  void _launchMaps({required double lat, required double lng}) async {
    final parameter = '?z=16&q=$lat,$lng';

    if (Platform.isIOS) {
      final googleMap = Uri.parse('comgooglemaps://' + parameter);
      final appleMap = Uri.parse('https://maps.apple.com/' + parameter);
      if (await canLaunchUrl(googleMap)) {
        await launchUrl(googleMap);
        return;
      }
      if (await canLaunchUrl(appleMap)) {
        await launchUrl(appleMap);
        return;
      }
    } else {
      final googleMapURL = Uri.parse('https://maps.google.com/' + parameter);
      if (await canLaunchUrl(googleMapURL)) {
        await launchUrl(googleMapURL);
        return;
      }
    }
    throw 'Could not launch url';
  }

  Future<void> _buildSingleMarker({required LatLng position}) async {
    final Uint8List markerIcon = await getBytesFromAsset(
      Asset.pinBikerImage,
      width: 150,
    );

    final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(markerIcon);

    final marker = Marker(
      markerId: MarkerId(jsonEncode(position)),
      icon: bitmap,
      infoWindow: InfoWindow(
        title: formatPosition(position),
        snippet: "",
        onTap: () => _launchMaps(lat: position.latitude, lng: position.longitude),
      ),
      position: position,
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
        onTap: (position) => _buildSingleMarker(position: position),
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
