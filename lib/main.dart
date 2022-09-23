import 'package:flutter/material.dart';

import 'package:gartenjeden/screens/app.dart';

void main() {
  runApp(const GartenJeden());
}

class GartenJeden extends StatelessWidget {
  const GartenJeden({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}