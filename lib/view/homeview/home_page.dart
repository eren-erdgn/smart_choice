import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {required this.onFavButtonPressed,
      required this.onCamButtonPressed,
      super.key});
  final void Function() onFavButtonPressed;
  final void Function() onCamButtonPressed;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Choice'),
      ),
      body: SingleChildScrollView( 
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: widget.onFavButtonPressed,
                child: Container(
                  padding: const EdgeInsets.all(100),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Icon(Icons.favorite,size: 40.0,)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0,),
              child: GestureDetector(
                onTap: widget.onCamButtonPressed,
                child: Container(
                  padding: const EdgeInsets.all(100),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Icon(Icons.camera_alt,size: 40.0)),
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: FirebaseAuth.instance.signOut,
                child: Container(
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Icon(Icons.exit_to_app,size: 40.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
