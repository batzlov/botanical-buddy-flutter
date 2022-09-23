import 'package:flutter/material.dart';

import 'package:gartenjeden/components/calendar.dart';
import 'package:gartenjeden/models/user.dart';

import 'package:gartenjeden/services/api_service.dart';

import 'package:gartenjeden/models/event.dart';
import 'package:gartenjeden/services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ApiService api = ApiService();
  
  var events = <Event>[];

  renderEventsToday() {
    var now = DateTime.now();
    var eventsToday = events.where((event) {
      return event.date.split(".")[0] == now.day.toString().padLeft(2, '0');
    }).toList();

    var items = <Widget>[];
    if(eventsToday.isEmpty) 
    {
      return const Text("Sieh dir unten im Kalender an was du für diese Woche zutun hast!");
    }
    else 
    {
      for(var i = 0; i < eventsToday.length; i++) {
        var color = eventsToday[i].eventType == EventType.pour ? const Color(0xFF9AD9DB) : const Color(0xFF98D4BB); 
        var row = Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50)
              ),
              height: 20,
              width: 20,
            ),
            const SizedBox(
              width: 10
            ),
            Text(
              eventsToday[i].details
            )
          ],
        );

        items.add(row);
      }
    }

    return Column(
      children: items
    );
  }

  @override
  void initState() {
    api.fetchEvents().then((fetchedEvents) {
      setState(() {
        events = fetchedEvents;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Deine Aufgaben",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const SizedBox(
                    height: 2
                  ),
                  renderEventsToday()
                ]
              ),
            )
          ),
          const SizedBox(
            height: 10
          ),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Monatsübersicht",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const Text(
                    "Legende:",
                    style: TextStyle(
                      fontSize: 16  
                    )
                  ),
                  const SizedBox(
                    height: 5
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFF9AD9DB)
                        ),
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5
                      ),
                      const Text(
                        "Gießen",
                        style: TextStyle(
                          fontSize: 16  
                        )
                      ),
                      const SizedBox(
                        width: 10
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color(0xFF98D4BB)
                        ),
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5
                      ),
                      const Text(
                        "Düngen",
                        style: TextStyle(
                          fontSize: 16  
                        )
                      ),
                    ]
                  ),
                  const SizedBox(
                    height: 5
                  ),
                  Calendar(
                    month: 2, 
                    year: 2022,
                    events: events
                  )
                ]
              )
            )
          )
        ]
      ),
    );
  }
}