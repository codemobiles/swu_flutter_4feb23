// To parse this JSON data, do
//
//     final locationResponse = locationResponseFromJson(jsonString);

import 'dart:convert';

LocationResponse locationResponseFromJson(String str) => LocationResponse.fromJson(json.decode(str));

String locationResponseToJson(LocationResponse data) => json.encode(data.toJson());

class LocationResponse {
  LocationResponse({
    required this.count,
    required this.positions,
  });

  final int count;
  final List<Position> positions;

  factory LocationResponse.fromJson(Map<String, dynamic> json) => LocationResponse(
        count: json["count"],
        positions: List<Position>.from(json["positions"].map((x) => Position.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "positions": List<dynamic>.from(positions.map((x) => x.toJson())),
      };
}

class Position {
  Position({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
