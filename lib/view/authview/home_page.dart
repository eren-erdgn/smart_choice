import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final user = FirebaseAuth.instance.currentUser!;
  List<int> selectedNumbers = List.filled(10, 0);
  
  @override
  void initState() {
    super.initState();
    fetchNumbers();
  }

  Future<void> fetchNumbers() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    List<dynamic> numbers = doc.get('myArrayField');
    for (int i = 0; i < numbers.length; i++) {
      selectedNumbers[numbers[i]] = numbers[i] + 1;
    }
    setState(() {});
  }

  void toggleNumber(int index) {
    setState(() {
      if (selectedNumbers[index] == 0) {
        selectedNumbers[index] = index + 1;
        appendToArray(index);
      } else {
        selectedNumbers[index] = 0;
        removeFromArray(index);
      }
    });
  }
  
  Future<void> appendToArray(dynamic element) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'myArrayField': FieldValue.arrayUnion([element]),
    });
  }

  Future<void> removeFromArray(dynamic element) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'myArrayField': FieldValue.arrayRemove([element]),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Counter'),
      ),
      body: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => toggleNumber(index),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selectedNumbers[index] != 0
                        ? Colors.blue
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: selectedNumbers[index] != 0
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
              10,
              (index) => Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '${selectedNumbers[index]}',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              color: Colors.deepPurple,
              child: const Text('sign out'),
            ),
        ],
      ),
    );
  }
}