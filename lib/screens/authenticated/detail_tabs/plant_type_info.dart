import 'package:flutter/material.dart';
import 'package:gartenjeden/shared/styles.dart';

import '../../../models/plant.dart';

class PlantTypeInfo extends StatelessWidget {
  PlantTypeInfo({ 
    Key? key,
    required this.plant
  }) : super(key: key);

  final Plant plant; 

  generateDescSegment(String title, String desc) {
    var segment = [];
    desc = desc.isEmpty ? "Keine Informationen vorhanden..." : desc;

    segment.add(Text(title, style: headline));
    segment.add(const SizedBox(height: 5));
    segment.add(Text(desc, style: text));
    segment.add(const SizedBox(height: 10));

    return segment;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...generateDescSegment("Beschreibung", plant.typeDetails.descGer!),
            ...generateDescSegment("Licht", plant.typeDetails.lightDesc!),
            ...generateDescSegment("Temperatur", plant.typeDetails.temDesc!),
            ...generateDescSegment("Feuchtigkeit", plant.typeDetails.moistureDesc!),
            ...generateDescSegment("Erde", plant.typeDetails.earthDesc!),
            ...generateDescSegment("Düngen", plant.typeDetails.fertilizeDesc!),
          ]
        ),
      ),
    );
  }
}