import 'package:flutter/material.dart';
import 'package:gartenjeden/components/icon_button_row.dart';
import 'package:gartenjeden/shared/styles.dart';

import '../../../models/plant.dart';
import '../../../services/api_service.dart';

class General extends StatelessWidget {
  General({ 
    Key? key,
    required this.plant 
  }) : super(key: key);

  final Plant plant;
  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    Future<void> showDeletePlantDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pflanze löschen'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Bist du dir sicher das du diese Pflanze löschen möchtest?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ja'),
                onPressed: () async {
                  var deleteWasSuccess = await api.deletePlant(plant);
                  if(deleteWasSuccess) {
                    Navigator.of(context).pop();
                    Navigator.pop(
                      context
                    );
                  } else {
                    print("something went wrong deleting the plant");
                  }
                },
              ),
              TextButton(
                child: const Text('Nein'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            plant.name,
            style: headline
          ),
          Text(
            'ist eine Pflanze vom Typ "${plant.name}". Deine Pflanze hat derzeit eine Höhe von 45cm.',
            style: text
          ),
          const SizedBox(
            height: 15
          ),
          IconButtonRow(
            headline: "Möchtest du die Pflanze löschen?", 
            subHeadline: "Abschiede sind immer schwer", 
            onPressed: () async {
              showDeletePlantDialog();
            }, 
            icon: const Icon(Icons.delete), 
            backgroundColor: Colors.red[600]!
          )
        ]
      )  
    );
  }
}