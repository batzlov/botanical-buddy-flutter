import 'package:flutter/material.dart';

class IntroHeadline extends StatelessWidget {
  const IntroHeadline({ Key? key, required this.headline, required this.subHeadline }) : super(key: key);

  final String headline;
  final String subHeadline;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          headline,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
          )
        ),
        const SizedBox(
          height: 3
        ),
        Text(
          subHeadline,
          style: const TextStyle(
            fontSize: 18
          )
        )
      ],
    );
  }
}