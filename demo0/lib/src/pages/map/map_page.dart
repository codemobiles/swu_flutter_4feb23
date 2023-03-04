import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:demo0/src/app.dart';
import 'package:demo0/src/bloc/map/map_bloc.dart';
import 'package:demo0/src/constants/asset.dart';
import 'package:demo0/src/services/common.dart';
import 'package:demo0/src/services/network_service.dart';
import 'package:demo0/src/widgets/custom_flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as maptoolkit;
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
    _buildPolygon();
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
    // send location to server
    context.read<MapBloc>().add(MapEvent_SubmitLocation(position));

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

  _buildPolygon() {
    final polygon = Polygon(
      polygonId: PolygonId("1"),
      consumeTapEvents: true,
      points: _dummyLatLng,
      strokeWidth: 2,
      onTap: () {
        final _mapToolkitLatLng = _dummyLatLng.map((e) {
          return maptoolkit.LatLng(e.latitude, e.longitude);
        }).toList();

        // https://www.mapdevelopers.com/area_finder.php
        // https://www.inchcalculator.com/convert/square-meter-to-square-kilometer/
        final meterArea = maptoolkit.SphericalUtil.computeArea(_mapToolkitLatLng);
        final kmArea = formatCurrency.format(meterArea / (1000000));
        print("Area: $kmArea ²Km");
        CustomFlushbar.showSuccess(navigatorState.currentContext!, message: "Area: $kmArea ²Km");
      },
      strokeColor: Colors.yellow,
      fillColor: Colors.yellow.withOpacity(0.15),
    );

    _polygons.add(polygon);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _zoomPolygon, icon: Icon(Icons.zoom_in_map)),
          IconButton(onPressed: _loadLocations, icon: Icon(Icons.folder_open)),
        ],
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
        polygons: _polygons,
        mapType: MapType.hybrid,
        trafficEnabled: true,
        initialCameraPosition: _initMap,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  Future<void> _zoomPolygon() async {
    final controller = await _controller.future;
    controller.moveCamera(
      CameraUpdate.newLatLngBounds(_boundsFromLatLngList(_dummyLatLng), 50),
    );
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1 = 0;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  void _loadLocations() {
    context.read<MapBloc>().add(MapEvent_LoadLocation());
  }
}
