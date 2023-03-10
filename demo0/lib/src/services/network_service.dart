import 'dart:convert';
import 'dart:io';

import 'package:demo0/src/models/LocationResponse.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/network_api.dart';

class NetworkService {
  int count = 0;

  // Singleton
  NetworkService._internal(); // SomeService();
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // await Future.delayed(Duration(seconds: 5));
          options.baseUrl = NetworkAPI.baseURL;
          options.headers = {HttpHeaders.contentTypeHeader: "application/json"};
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // await Future.delayed(Duration(seconds: 10));
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          switch (e.response?.statusCode) {
            case 301:
              break;
            case 401:
              break;
            default:
          }
          return handler.next(e);
        },
      ),
    );

  Future<LocationResponse?> loadLocations() async {
    try {
      final response = await _dio.get("/load_locations");
      if (response.statusCode == 200) {
        final result = LocationResponse.fromJson(response.data);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String> submitLocation(LatLng position) async {
    var params = {"lat": position.latitude, "lng": position.longitude};
    Response response = await _dio.post("/submit_location", data: jsonEncode(params));
    if (response.statusCode == 201) {
      return 'Submit Successfully';
    } else {
      return 'Submit Failed';
    }
  }

  method1() {
    count++;
    print("Count: $count");
  }
}
