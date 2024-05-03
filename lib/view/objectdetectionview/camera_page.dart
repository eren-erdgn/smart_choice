import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';
import 'package:ultralytics_yolo/yolo_model.dart';

class CameraPage extends StatefulWidget {
  const CameraPage(this.onCameraButtonPressed,{super.key});
  final void Function(bool isButtonPressed, List<DetectedObject> detectedObjects) onCameraButtonPressed;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final controller = UltralyticsYoloCameraController();
  List<DetectedObject>? detectedObjects;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isButtonPressed = false;

    void listObject(isButtonPressed, detectedObjects) {
      if(isButtonPressed){
        widget.onCameraButtonPressed(isButtonPressed, detectedObjects);
      }
    }
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkPermissions(),
        builder: (context, snapshot) {
          final allPermissionsGranted = snapshot.data ?? false;

          return !allPermissionsGranted
              ? Container()
              : FutureBuilder<ObjectDetector>(
                  future: _initObjectDetectorWithLocalModel(),
                  builder: (context, snapshot) {
                    final predictor = snapshot.data;

                    return predictor == null
                        ? Container()
                        : Stack(
                            children: [
                              UltralyticsYoloCameraPreview(
                                controller: controller,
                                predictor: predictor, 
                                onCameraCreated: () {  
                                  predictor.loadModel(useGpu: true);
                                },
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      predictor
                                        .detectionResultStream
                                        .listen((List<DetectedObject?>? result) {
                                            setState(() {
                                                detectedObjects = result?.cast<DetectedObject>();
                                            });

                                            if (detectedObjects != null && detectedObjects!.isNotEmpty) {
                                                isButtonPressed = true;
                                                print('Detected Objects are here');
                                                listObject(isButtonPressed,detectedObjects);
                                                
                                            }
                                        });
                                    },
                                    child: const Text('Show Results'),
                                  ),
                                ),
                              ),
                            ],
                          );
                  },
                );
        },
      ),
    );
  }

  Future<ObjectDetector> _initObjectDetectorWithLocalModel() async {
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

  Future<bool> _checkPermissions() async {
    List<Permission> permissions = [];

    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) permissions.add(Permission.camera);

    var storageStatus = await Permission.storage.status;
    if (!storageStatus.isGranted) permissions.add(Permission.storage);

    if (permissions.isEmpty) {
      return true;
    } else {
      try {
        Map<Permission, PermissionStatus> statuses =
            await permissions.request();
        return statuses[Permission.camera] == PermissionStatus.granted &&
            statuses[Permission.storage] == PermissionStatus.granted;
      } on Exception catch (_) {
        return false;
      }
    }
  }
}

