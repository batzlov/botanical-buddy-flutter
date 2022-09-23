import 'package:flutter/material.dart';
import 'package:dart_date/dart_date.dart';

import '../models/event.dart';

class Calendar extends StatelessWidget {
  Calendar({ Key? key, required this.month, required this.year, this.events }) : super(key: key);

  final int month;
  final int year;
  var events;

  dynamic getDaysInMonth(month, year) {
    return DateTime(year, month + 1, 0).day;
  }

  // month are from 1 .. 12
  // days are 1 .. 7 -> 7 is sunday
  dynamic prepareDaysInMonth(month, year) {
    final daysInMonth = getDaysInMonth(month, year);
    final firstOfMonth = DateTime(year, month, 1);
    final lastOfMonth = DateTime(year, month, daysInMonth);

    var rangeStart = firstOfMonth.subDays(firstOfMonth.weekday - 1); 
    var rangeEnd = lastOfMonth.addDays(7 - lastOfMonth.weekday); 
      
    // number fo days to display
    var numOfDaysToDisplay = rangeEnd.differenceInDays(rangeStart) + 1;

    var days = [];
    for(var i = 0; i < numOfDaysToDisplay; i++) {
      var date = rangeStart.addDays(i); 
      days.add(date);
    }

    return days;
  }

  dynamic dayHasEvent(day, events) {
    var filteredEvents = events.where((event) {
      return event.date.split(".")[0] == day.day.toString().padLeft(2, '0');
    }).toList();

    if(filteredEvents.length > 1) {
      return filteredEvents[1].eventType == EventType.fertilize ? filteredEvents[1] : filteredEvents[0];
    }

    return filteredEvents.length == 0 ? null : filteredEvents[0];
  }

  Widget generateDay(day) {
    var bgColor = day.month == month ? const Color(0xFFECECEC) : const Color(0xFF555555);
    var event = dayHasEvent(day, events);
    if(bgColor == const Color(0xFFECECEC) && event != null) {
      if(event.eventType == EventType.pour) {
        bgColor = const Color(0xFF9AD9DB);
      } else if(event.eventType == EventType.fertilize) {
        bgColor = const Color(0xFF98D4BB);
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 2
      ),
      alignment: Alignment.center,
      height: 38,
      width: 38,
      child: Text(day.day.toString()),
    );
  }

  Widget generateWeek(days) {
    var weekDays = <Widget>[];

    for (var i = 0; i < days.length; i++) {
      weekDays.add(generateDay(days.elementAt(i)));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekDays
    );
  }

  List<Widget> generateCalendarLayout() {
    var days = prepareDaysInMonth(month, year);
    var rowsCount = days.length / 7;
    var layout = <Widget>[];

    var from = 0;
    var to = 6;
    for(var i = 0; i < rowsCount; i++) {
      var weekDays = days.sublist(from, to + 1);
      layout.add(generateWeek(weekDays));

      from += 7;
      to += 7;
    }

    return layout;
  }

  @override
  Widget build(BuildContext context) {
    var layout = generateCalendarLayout();

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFECECEC)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.center,
              height: 38,
              width: 38,
              child: const Text("Mo"),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFECECEC)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.center,
              height: 38,
              width: 38,
              child: const Text("Di"),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFECECEC)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.center,
              height: 38,
              width: 38,
              child: const Text("Mi"),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFECECEC)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.center,
              height: 38,
              width: 38,
              child: const Text("Do"),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFECECEC)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.center,
              height: 38,
              width: 38,
              child: const Text("Fr"),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFECECEC)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.center,
              height: 38,
              width: 38,
              child: const Text("Sa"),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFECECEC)
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2
              ),
              alignment: Alignment.center,
              height: 38,
              width: 38,
              child: const Text("So"),
            ),
          ]
        ),
        ...layout
      ]
    );
  }
}