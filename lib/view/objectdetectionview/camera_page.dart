import 'package:flutter/material.dart';
import 'package:smart_choice/viewmodel/cameravm/camera_view_model.dart';
import 'package:ultralytics_yolo/ultralytics_yolo.dart';

class CameraPage extends StatefulWidget {
  const CameraPage(this.onCameraButtonPressed, {super.key});
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
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _cameraViewModel.checkCameraPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.data!) {
            return const Center(
              child: Text("You need to give permission for the camera"),
            );
          }
          return FutureBuilder<ObjectDetector>(
            future: _cameraViewModel.initObjectDetectorWithLocalModel(),
            builder: (context, snapshot) {
              final predictor = snapshot.data;
              if (predictor == null) {
                return Container();  // Show nothing if the detector is not ready
              }
              return Stack(
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
                          predictor.detectionResultStream.listen((List<DetectedObject?>? result) {
                            setState(() {
                              detectedObjects = result?.cast<DetectedObject>();
                            });
                            if (detectedObjects != null && detectedObjects!.isNotEmpty) {
                              widget.onCameraButtonPressed(true, detectedObjects!);
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
