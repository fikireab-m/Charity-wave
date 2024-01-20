import 'package:charitywave/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Region {
  final int id;
  final String title;
  final String subtitle;
  final LatLng location;
  final Status status;
  final List<Category> supportCategories;
  final List<String> images;
  final int volunteerID;
  final int suppID;
  final String description;
  final int addedAt;
  Region({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.supportCategories,
    required this.status,
    required this.images,
    required this.volunteerID,
    required this.suppID,
    required this.description,
    required this.addedAt,
  });

  factory Region.fromJson(json) {
    return Region(
      id: json["id"],
      title: json["name"],
      subtitle: "War",
      location: LatLng(json["geo"][1], json["geo"][0]),
      supportCategories: json["need"],
      status: Status.red,
      images: json["images"],
      volunteerID: json["volunteerID"],
      suppID: json["suppID"],
      description: json["description"],
      addedAt: json["addedAt"],
    );
  }

  Map<String, dynamic> toJson([bool toStr = false]) {
    return <String, dynamic>{
      "id": id,
      "name": title,
      "subtitle": subtitle,
      "geo": location,
      "need": supportCategories,
      "status": Status.red,
      "images": images,
      "volunteerID": volunteerID,
      "suppID": suppID,
      "description": description,
      "addedAt": addedAt
    };
  }
}

enum Status { red, green, lightGreen }
