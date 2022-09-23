import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as ImageManipulator;
import 'dart:io' as io;
import 'dart:convert';

enum CameraType {
  back,
  front
}

class CameraHandler extends StatefulWidget {
  const CameraHandler({ 
    Key? key,
    this.cameras 
  }) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  _CameraHandlerState createState() => _CameraHandlerState();
}

class _CameraHandlerState extends State<CameraHandler> {
  var selectedCamera = CameraType.back;
  var showImagePreview = false;
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();

    controller = CameraController(
      widget.cameras![selectedCamera.index],
      ResolutionPreset.max,
    );

    controller.initialize().then((_) {
      if(!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void initializeCameraController(int cameraIndex) {
    controller = CameraController(
      widget.cameras![cameraIndex],
      ResolutionPreset.max,
    );

    controller.initialize().then((_) {
      if(!mounted) {
        return;
      }

      setState(() {
        if(cameraIndex == 0) {
          selectedCamera = CameraType.back;
        } else {
          selectedCamera = CameraType.front;
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var borderHeight = (MediaQuery.of(context).size.height - 500) / 2;
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var bgColor = const Color.fromRGBO(0, 0, 0, 0.9);

    if(!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if(showImagePreview && pictureFile != null) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: screenWidth,
              height: screenHeight,
              child: Image.file(
                io.File(pictureFile!.path),
                fit: BoxFit.fill,
              )
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
                        onPressed: () async {
                          var originalFile = io.File(pictureFile!.path);
                          var decodeImg = ImageManipulator.decodeImage(originalFile.readAsBytesSync());
                          var otherImg = await decodeImageFromList(originalFile.readAsBytesSync());
                          
                          int x = 0;
                          int y = (0.5 * otherImg.height - 0.5 * otherImg.width).toInt();
                          var croppedImage = ImageManipulator.copyCrop(
                            decodeImg!,
                            x,
                            y,
                            otherImg.width,
                            otherImg.width
                          );
                          var resizedImage = ImageManipulator.copyResize(
                            croppedImage,
                            height: 500,
                            width: 500
                          );

                          String base64Image = base64Encode(ImageManipulator.encodeJpg(
                            resizedImage,
                            quality: 70
                          ));

                          Navigator.pop(
                            context,
                            base64Image
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
              width: screenWidth,
              height: screenHeight,
              child: CameraPreview(controller)
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
                          if(selectedCamera == CameraType.back) {
                            initializeCameraController(CameraType.front.index);
                          } else {
                            initializeCameraController(CameraType.back.index);
                          }
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
                              onPressed: () async {
                                pictureFile = await controller.takePicture();
                                if(pictureFile != null) {
                                  setState(() {
                                    showImagePreview = true;
                                  });
                                }
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