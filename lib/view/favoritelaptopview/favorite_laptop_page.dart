import 'package:flutter/material.dart';

class FavoriteLaptopPage extends StatelessWidget {
  const FavoriteLaptopPage({super.key,required this.onHomeButtonPressed});
  final void Function() onHomeButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FavortieLaptopPage'),
      ),
      body: const Center(
        child: Text(
          'FavortieLaptops',
          style: TextStyle(fontSize: 20),
        ),
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
