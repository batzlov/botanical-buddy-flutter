import 'package:flutter/material.dart';

class FakeCamera extends StatefulWidget {
  const FakeCamera({ Key? key }) : super(key: key);

  @override
  _FakeCameraState createState() => _FakeCameraState();
}

class _FakeCameraState extends State<FakeCamera> {
  var showImagePreview = false;
  @override
  Widget build(BuildContext context) {
    var borderHeight = (MediaQuery.of(context).size.height - 500) / 2;
    var screenWidth = MediaQuery.of(context).size.width;
    var bgColor = const Color.fromRGBO(0, 0, 0, 0.9);


    if(showImagePreview) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue,
            ),
            Container(
              width: screenWidth,
              height: borderHeight,
              color: bgColor
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: screenWidth,
                height: borderHeight,
                color: bgColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        left: 5
                      ),
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: const Icon(Icons.refresh),
                        iconSize: 45,
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            showImagePreview = false;
                          });
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        right: 15
                      ),
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: const Icon(Icons.check_circle),
                        iconSize: 45,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(
                            context,
                            [
                              "pathToFile: /assets/images",
                              true
                            ]
                          );
                        },
                      ),
                    ),
                  ]
                )
              ),
            ),
          ]
        )
      );
    } else {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.red,
            ),
            Container(
              width: screenWidth,
              height: borderHeight,
              color: bgColor
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: screenWidth,
                height: borderHeight,
                color: bgColor,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        left: 15
                      ),
                      height: 50,
                      width: 50,
                      child: IconButton(
                        icon: const Icon(Icons.refresh),
                        iconSize: 45,
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            showImagePreview = false;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 65
                            ),
                            height: 80,
                            width: 80,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80)
                              )
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt),
                              iconSize: 45,
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  showImagePreview = true;
                                });
                              },
                            ),
                          ),
                        ),
                    ),
                  ]
                )
              ),
            ),
          ]
        ),
      );
    }
  }
}