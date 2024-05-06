import 'package:flutter/material.dart';
import 'package:smart_choice/view/favoritelaptopview/favorite_laptop_page.dart';
import 'package:smart_choice/view/objectdetectionview/camera_page.dart';
import 'package:smart_choice/view/objectdetectionview/detection_result_page.dart';
import 'package:smart_choice/view/homeview/home_page.dart';
import 'package:ultralytics_yolo/predict/detect/detected_object.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _activeScreen = 'home-page';
  List<DetectedObject> detectedObjects = [];

  void _goFav(){
    setState(() {
      _activeScreen = 'favorite-laptops-page';
    });
  } 
  void _goCam(){
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
    Widget screenWidget = HomePage(onCamButtonPressed: _goCam,onFavButtonPressed: _goFav,);

    if(_activeScreen == 'favorite-laptops-page'){
      screenWidget = FavoriteLaptopPage(onHomeButtonPressed: _goHome,);
    }
    
    if(_activeScreen == 'camera-page'){
      screenWidget = CameraPage(_listObject);
    }
    if(_activeScreen == 'detection-result-page'){
      screenWidget = DetectionResultPage(detectedObjects:detectedObjects, onHomeButtonPressed: _goHome);
    }
    return screenWidget;
  }
}