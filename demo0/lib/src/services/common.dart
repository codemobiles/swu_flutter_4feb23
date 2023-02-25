import 'dart:typed_data';
import 'dart:ui';

import 'package:demo0/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

Future<Uint8List> getBytesFromAsset(
    String path, {
      required int width,
    }) async {
  ByteData data = await rootBundle.load(path);
  Codec codec = await instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

Future<bool> checkPermission(Location locationService) async {
  var permissionGranted = await locationService.hasPermission();
  if (permissionGranted == PermissionStatus.granted) {
    return true;
  }
  permissionGranted = await locationService.requestPermission();
  return permissionGranted == PermissionStatus.granted;
}

Future<bool> checkServiceGPS(Location locationService) async {
  var serviceEnabled = await locationService.serviceEnabled();
  if (serviceEnabled) {
    return true;
  }
  serviceEnabled = await locationService.requestService();
  return serviceEnabled;
}



void hideKeyboard(){
  FocusScope.of(navigatorState.currentContext!).requestFocus(FocusNode());
}