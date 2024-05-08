import 'package:flutter/material.dart';
import 'package:smart_choice/viewmodel/cameravm/camera_view_model.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';

class CameraPage extends StatefulWidget {
  const CameraPage(this.onCameraButtonPressed,{super.key});
  final void Function(bool isButtonPressed, List<DetectedObject> detectedObjects) onCameraButtonPressed;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final CameraViewModel _cameraViewModel = CameraViewModel();
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
        future: _cameraViewModel.checkPermissions(),
        builder: (context, snapshot) {
          final allPermissionsGranted = snapshot.data ?? false;

          return !allPermissionsGranted
              ? Container()
              : FutureBuilder<ObjectDetector>(
                  future: _cameraViewModel.initObjectDetectorWithLocalModel(),
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
}

