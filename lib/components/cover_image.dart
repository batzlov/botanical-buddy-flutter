import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key, Widget? this.childWidget}) : super(key: key);
  
  final Widget? childWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/plant_bg.jpg"), fit: BoxFit.cover,),
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 0.8),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: childWidget
                )
              ),
            ),
          ),
        ]
      )
    );
  }
}