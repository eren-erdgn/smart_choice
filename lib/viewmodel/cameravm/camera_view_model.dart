
import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';
import 'package:ultralytics_yolo/yolo_model.dart';

class CameraViewModel {

  Future<ObjectDetector> initObjectDetectorWithLocalModel() async {
    final modelPath = await _copy('assets/yolov8n.mlmodel');
    final model = LocalYoloModel(
      id: '',
      task: Task.detect,
      format: Format.coreml,
      modelPath: modelPath,
    );
    return ObjectDetector(model: model);
  }

  Future<String> _copy(String assetPath) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  Future<bool> checkCameraPermission() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      var status = await Permission.camera.request();
      return status == PermissionStatus.granted;
    }
    return true;  // Return true if permission is already granted
  }
  
 

}