import 'package:flutter/material.dart';

class IconButtonRow extends StatelessWidget {
  IconButtonRow({ 
    Key? key, 
    required this.headline, 
    required this.subHeadline, 
    required this.onPressed,
    required this.icon,
    required this.backgroundColor 
  }) : super(key: key);

  final String headline;
  final String subHeadline;
  final Function onPressed; 
  final Widget icon;
  final Color backgroundColor;

  var headlineStyle = const TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold
  );

  var textStyle = const TextStyle(
    fontSize: 15
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              headline,
              style: headlineStyle,
            ),
            Text(
              subHeadline,
              style: textStyle,
            ),
          ]
        ),
        Ink(
          decoration: ShapeDecoration(
            color: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
          child: IconButton(
            icon: icon,
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              onPressed();
            },
          ),
        ),
      ],
    );
  }
}