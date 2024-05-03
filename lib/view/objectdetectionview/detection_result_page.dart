import 'package:flutter/material.dart';
import 'package:ultralytics_yolo/predict/detect/detected_object.dart';

class DetectionResultPage extends StatelessWidget {
  final List<DetectedObject> detectedObjects;

  const DetectionResultPage({super.key, required this.detectedObjects, required this.onHomeButtonPressed});
  final void Function() onHomeButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results'),
      ),
      body: ListView.builder(
        itemCount: detectedObjects.length,
        itemBuilder: (context, index) {
          final object = detectedObjects[index];
          return Card(
            child: ListTile(
              title: Text('Object: ${object.label}'),
              subtitle:
                  Text('Confidence: ${object.confidence.toStringAsFixed(2)}'),
              onTap: () {
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
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onHomeButtonPressed();
        }, 
        backgroundColor: Colors.green,
        child: const Icon(Icons.home), 
      ),
    );
  }
}
