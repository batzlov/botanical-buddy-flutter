import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({ Key? key, required this.headline, this.subHeadline, this.headerHeight, this.childWidget }) : super(key: key);

  final String headline;
  final String? subHeadline;
  final double? headerHeight;
  final Widget? childWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: headerHeight,
      color: const Color(0xff50665a),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 25,
          bottom: 15,
          left: 25,
          right: 25
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              headline,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.bold
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5
              ),
              child: Container(
                color: Colors.white,
                height: 3,
              ),
            ),
            if(subHeadline != "") ...[
              Text(
                subHeadline!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17
                )
              )
            ],
            if(childWidget != null) ...[
              childWidget!
            ]
          ]
        ),
      ),
    );
  }
}