import 'package:flutter/material.dart';
import 'package:smart_choice/view/laptopview/os_choice_page.dart';
import 'package:ultralytics_yolo/predict/detect/detected_object.dart';

class DetectionResultPage extends StatelessWidget {
  final List<DetectedObject> detectedObjects;

  const DetectionResultPage({super.key, required this.detectedObjects, required this.onHomeButtonPressed});
  final void Function() onHomeButtonPressed;
  

  @override
  Widget build(BuildContext context) {

    Set<String> uniqueLabels = {};
    List<DetectedObject> uniqueDetectedObjects = [];

    for (final object in detectedObjects) {
      if (!uniqueLabels.contains(object.label) && object.label != "person") {
        uniqueLabels.add(object.label);
        uniqueDetectedObjects.add(object);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results'),
      ),
      body: ListView.builder(
        itemCount: uniqueDetectedObjects.length,
        itemBuilder: (context, index) {
          final object = uniqueDetectedObjects[index];
          return Card(
            child: ListTile(
              title: Text('Object: ${object.label}'),
              onTap: () {
                if (object.label == "laptop") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OsChoicePage()
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Warning!"),
                        content: Text("${object.label} product has not been added to the system yet."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onHomeButtonPressed();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.home),
      ),
    );
  }
}
