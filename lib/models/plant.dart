import 'package:botanicalbuddy/models/plant_type.dart';

import './plant_type.dart';

class Plant {
  int id;
  String name;
  String type;
  int height;
  String imageRef;
  int ownerId;
  PlantType typeDetails;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.height,
    required this.imageRef,
    required this.ownerId,
    required this.typeDetails
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      height: json['height'],
      imageRef: json['imageRef'],
      ownerId: json['ownerId'],
      typeDetails: PlantType.fromJson(json['parent'])
    );
  }
}