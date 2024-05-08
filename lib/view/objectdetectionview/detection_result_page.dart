import 'package:flutter/material.dart';
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
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Object Details'),
                        ),
                        body: Center(
                          child: Text(
                            'Details about ${object.label}',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Uyari!"),
                        content: Text("${object.label} henüz sisteme eklenmemiştir."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Tamam"),
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
