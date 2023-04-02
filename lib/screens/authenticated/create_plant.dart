import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:botanicalbuddy/screens/authenticated/camera_handler.dart';
import 'package:botanicalbuddy/screens/authenticated/fake_camera.dart';
import 'package:botanicalbuddy/services/api_service.dart';
import 'package:botanicalbuddy/shared/styles.dart';
import 'dart:convert';

import '../../components/button.dart';
import '../../components/header.dart';

class CreatePlant extends StatefulWidget {
  const CreatePlant({ Key? key }) : super(key: key);

  @override
  _CreatePlantState createState() => _CreatePlantState();
}

class _CreatePlantState extends State<CreatePlant> {
  final formKey = GlobalKey<FormState>();
  final ApiService api = ApiService();

  bool imageWasTaken = false;
  late File takenImage;
  late String imageBaseString;
  String plantName = "";
  String plantType = "";
  int plantTypeId = 0;
  int plantHeight = 0;

  var plantTypes = [];

  @override
  initState() {
    api.fetchPlantTypesByName("").then((fetchedPlantTypes) {
      setState(() {
        plantTypes = fetchedPlantTypes;
      });
    });

    super.initState();
  }

  updatePlantType(String name, int id) {
    setState(() {
      plantTypeId = id;
      plantType = name;
    });
  }

  generateSelectableItems() {
    var items = <Widget>[];

    plantTypes.forEach((type) {
      items.add(GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
          updatePlantType(
            type.nameGer, 
            type.id
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10)  
          ),
          child: Text(
            type.nameGer + " - " + type.nameLat!,
            textAlign: TextAlign.center,
          ),
        ),
      ));
      items.add(
        const SizedBox(
          height: 7
        )
      );
    });

    return items;
  }

  void showSelectPlantTypeModal() {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setChildState) {
            return Container(
              height: MediaQuery.of(context).size.height - 80,
              color: const Color(0xFF737373),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(35),
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: "Suche eine Pflanzenart..."
                        ),
                        onChanged: (value) async {
                          var plantTypesByName = await api.fetchPlantTypesByName(value);
                          setChildState(() {
                            plantTypes = plantTypesByName;
                          });
                        }
                      ),
                      const SizedBox(
                        height: 10
                      ),
                      Button(
                        text: "zurück", 
                        action: () {
                          Navigator.of(context).pop();
                        },
                        backgroundColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 10
                      ),
                      ...generateSelectableItems()
                    ]
                  )
                )
              )
            );
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: Header(
          headline: "Pflanze hinzufügen",
          subHeadline: "Bitte fülle das Formular aus und klicke dann auf senden.",
          headerHeight: 140
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: "Name"
                        ),
                        validator: (value) {
                          if(value!.length < 2) {
                            return "Bitte gib einen gültigen Namen ein.";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            plantName = value;
                          });
                        }
                      ),
                      const SizedBox(
                        height: 20
                      ),
                      TextFormField(
                        key: Key(plantType),
                        decoration: textInputDecoration.copyWith(
                          hintText: "Art"
                        ),
                        initialValue: plantType,
                        readOnly: true,
                        onTap: () {
                          showSelectPlantTypeModal();
                        },
                        validator: (value) {
                          if(value!.length < 2) {
                            return "Bitte wähle eine Art aus.";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            plantType = value;
                          });
                        }
                      ),
                      const SizedBox(
                        height: 20
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                          hintText: "Höhe in cm"
                        ),
                        validator: (value) {
                          if(value!.length < 2) {
                            return "Bitte gib eine Höhe ein.";
                          }
                          else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            plantHeight = int.parse(value);
                          });
                        }
                      ),
                    ]
                  ),
                ),
                const SizedBox(
                  height: 20
                ),
                const Text(
                  "Bitte füge ein Bild deiner Pflanze hinzu."
                ),
                const SizedBox(
                  height: 15
                ),
                Row(
                  children: [
                    if(imageWasTaken) ...[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 150,
                        width: 150,
                        child: Image.memory(
                          const Base64Decoder().convert(imageBaseString),
                          fit: BoxFit.contain,
                        )
                      ),
                    ],
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: ShapeDecoration(
                            color: const Color.fromRGBO(95, 15, 62, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80)
                            )
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt),
                            iconSize: 42,
                            color: Colors.white,
                            onPressed: () async {
                              var cameras = await availableCameras();
                              if(cameras.isEmpty) {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FakeCamera(),
                                  ),
                                );
                              } else {
                                var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CameraHandler(cameras: cameras),
                                  ),
                                );

                                setState(() {
                                  imageBaseString = result;
                                  imageWasTaken = true;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Button(
                        text: "zurück",
                        action: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10
                    ),
                    Expanded(
                      child: Button(
                        text: "senden",
                        action: () async {
                          if(formKey.currentState!.validate() && imageBaseString.isNotEmpty) {
                            var res = await api.savePlant(plantName, plantType, plantHeight, plantTypeId, imageBaseString);

                            if(res) {
                              Navigator.of(context).pop();
                            }  
                          } else {
                            print("form is not valid");
                          }
                        },
                      ),
                    )
                  ]
                )
              ]
            ),
          ),
        )
      ),
    );
  }
}