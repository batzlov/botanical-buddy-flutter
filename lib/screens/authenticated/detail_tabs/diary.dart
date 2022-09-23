import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gartenjeden/components/button.dart';
import 'package:gartenjeden/shared/styles.dart';

import '../../../models/plant.dart';
import '../../../models/diary_entry.dart';
import '../../../services/api_service.dart';

class Diary extends StatefulWidget {
  const Diary({ 
    Key? key,
    required this.plant 
  }) : super(key: key);

  final Plant plant;

  @override
  _DiaryState createState() => _DiaryState(plantId: plant.id);
}

class _DiaryState extends State<Diary> {
  _DiaryState({required this.plantId});
  
  final formKey = GlobalKey<FormState>();
  int plantId = 0;
  int plantHeight = 0;
  ApiService api = ApiService();
  List<DiaryEntry> diaryEntries = [];

  @override
  void initState() {
    api.fetchDiaryEntries(plantId).then((fetchedDiaryEntries) {
      setState(() {
        diaryEntries = fetchedDiaryEntries;
      });
    });

    super.initState();
  }

  List<charts.Series<DiaryEntry, DateTime>> createDiagramData() {
    return [
      charts.Series<DiaryEntry, DateTime>(
        id: 'Höhe in cm',
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        domainFn: (DiaryEntry entry, _) => entry.notedAt,
        measureFn: (DiaryEntry entry, _) => entry.height,
        data: diaryEntries,
      )
    ];
  }

  showAddHeight() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 290,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Neue Höhe hinzufügen",
                    style: headline
                  ),
                  Text(
                    "Messe deine Pflanze und füge einen neuen Wachstums Eintrag hinzu.",
                    style: text
                  ),
                  const SizedBox(
                    height: 20
                  ),
                  Form(
                    key: formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: textInputDecoration.copyWith(
                              hintText: "Höhe in cm"
                            ),
                            validator: (value) {
                              if(value!.isEmpty == true) {
                                return "Bitte gib eine gültige Höhe ein.";
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
                        ), 
                        const SizedBox(
                          width: 10
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          decoration: ShapeDecoration(
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.save),
                            iconSize: 30,
                            color: Colors.white,
                            onPressed: () async {
                              if(formKey.currentState!.validate()) {
                                var savingWasSuccess = await api.saveDiaryEntry(plantId, plantHeight);
                                if(savingWasSuccess) {
                                  var entries = await api.fetchDiaryEntries(plantId);
                                  setState(() {
                                    diaryEntries = entries;
                                    Navigator.of(context).pop();
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(
                    height: 20
                  ),
                  Button(
                    text: "zurück", 
                    action: () {
                      Navigator.of(context).pop();
                    }
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Tagebuch",
            style: headline
          ),
          Text(
            "Hier kannst du das Wachstum deiner Pflanze festhalten.",
            style: text
          ),
          const SizedBox(
            height: 10
          ),
          Text(
            "Wachstum",
            style: subHeadline
          ),
          GestureDetector(
            onTap: () {
              showAddHeight();
            },
            child: Text(
              "Wachstumspunkte hinzufügen",
              style: text.copyWith(
                decoration: TextDecoration.underline
              )
            ),
          ),
          const SizedBox(
            height: 10
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(240, 243, 250, 1),
              gradient: const LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Color.fromRGBO(245, 245, 245, 1),
                  Color.fromRGBO(242, 240, 250, 1),
                ],
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            height: 250,
            width: 250,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: charts.TimeSeriesChart(
                createDiagramData(),
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                defaultRenderer: charts.LineRendererConfig(includePoints: true),
              ),
            )
          ),
        ],
      ),
    );
  }
}