import 'package:flutter/material.dart';

import 'package:botanicalbuddy/screens/app.dart';

void main() {
  runApp(const BotanicalBuddy());
}

class BotanicalBuddy extends StatelessWidget {
  const BotanicalBuddy({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
    );
  }
}