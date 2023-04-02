import 'package:flutter/material.dart';

import 'package:botanicalbuddy/components/button.dart';

import 'package:botanicalbuddy/services/api_service.dart';

class Test extends StatefulWidget {
  const Test({ Key? key }) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  int requestDuration = 0;
  ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Der Request hat ${requestDuration.toString()}ms gedauert.",
                style: TextStyle(
                  fontSize: 16
                ),
              ),
              SizedBox(
                height: 5
              ),
              Button(
                text: "Request starten",
                action: () async {
                  int measuredTime = await api.measureRequestTime();
                  setState(() {
                    requestDuration = measuredTime;
                  });
                }
              )
            ],
          )
        )
      )
    );
  }
}