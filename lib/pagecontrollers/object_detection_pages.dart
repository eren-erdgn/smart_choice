import 'package:flutter/material.dart';
import 'package:smart_choice/view/objectdetectionview/camera_page.dart';
import 'package:smart_choice/view/objectdetectionview/detection_result_page.dart';
import 'package:smart_choice/view/authview/home_page.dart';
import 'package:ultralytics_yolo/predict/detect/detected_object.dart';

class ObjectDetectionPages extends StatefulWidget {
  const ObjectDetectionPages({super.key});

  @override
  State<ObjectDetectionPages> createState() => _ObjectDetectionPagesState();
}

class _ObjectDetectionPagesState extends State<ObjectDetectionPages> {
  var _activeScreen = 'home-page';
  List<DetectedObject> detectedObjects = [];
  void _switchScreen() {
    setState(() {
      _activeScreen = 'camera-page';
    });
  }
  void _listObject(bool isButtonPressed, List<DetectedObject> detectedObj) {
    if(isButtonPressed){
      detectedObjects = detectedObj;
      setState(() {
        _activeScreen = 'detection-result-page';
      });
    }
  }
  void _goHome() {
    setState(() {
      _activeScreen = 'home-page';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = HomePage(onCameraButtonPressed:_switchScreen);

    if(_activeScreen == 'camera-page'){
      screenWidget = CameraPage(_listObject);
    }
    if(_activeScreen == 'detection-result-page'){
      screenWidget = DetectionResultPage(detectedObjects:detectedObjects, onHomeButtonPressed: _goHome);
    }
    return screenWidget;
  }
}