import 'package:flutter/material.dart';

import 'package:gartenjeden/screens/authenticated/detail_tabs/general.dart';
import 'package:gartenjeden/screens/authenticated/detail_tabs/diary.dart';
import 'package:gartenjeden/screens/authenticated/detail_tabs/plant_type_info.dart';

import '../../models/plant.dart';

import '../../constants/config.dart';

class Details extends StatefulWidget {
  const Details({ 
    Key? key,
    required this.plant 
  }) : super(key: key);

  final Plant plant;

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  IconData activeIcon = Icons.home;
  int activeIndex = 0;

  TabBarBtn(IconData icon, String label) {
    var isActiveTab = icon == activeIcon;
    var color = isActiveTab ? Colors.white : Colors.grey[500];

    return GestureDetector(
      onTap: () {
        setState(() {
          activeIcon = icon;

          if(icon == Icons.home) {
            activeIndex = 0;
          } else if(icon == Icons.book_sharp) {
            activeIndex = 1;
          } else {
            activeIndex = 2;
          }
        });
      },
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 35,
              width: 35,
              child: Icon(
                icon,
                color: color,
                size: isActiveTab ? 30 : 25
              )
            ),
            Text(
              label,
              style: TextStyle(
                color: color
              )
            )
          ]
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    var tabs = [
      General(
        plant: widget.plant
      ),
      Diary(
        plant: widget.plant
      ),
      PlantTypeInfo(
        plant: widget.plant
      )
    ];

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            baseUrl+"/uploads/"+widget.plant.imageRef,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover
          ),
          Container(
            height: 70,
            color: const Color(0xFF50665a),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TabBarBtn(Icons.home, "Übersicht"),
                TabBarBtn(Icons.book_sharp, "Tagebuch"),
                TabBarBtn(Icons.nature, "Art-Details")
              ]
            )
          ),
          Container(
            height: MediaQuery.of(context).size.height - 370,
            child: tabs.elementAt(activeIndex)
          )
        ]
      )
    );
  }
}