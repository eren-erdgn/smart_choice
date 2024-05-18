import 'package:smart_choice/view/favoritelaptopview/favorite_laptop_page.dart';
import 'package:flutter/material.dart';

class FavoriteOsPage extends StatefulWidget {
  const FavoriteOsPage({super.key});

  @override
  State<FavoriteOsPage> createState() => _FavoriteOsPageState();
}

class _FavoriteOsPageState extends State<FavoriteOsPage> {
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteLaptopPage(
                        laptopCpu: 'laptopsmac',
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(100),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text("Apple Silicon Chips",style: TextStyle(color: Colors.white,fontSize: 20),)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteLaptopPage(
                        laptopCpu: 'laptops',
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(100),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Intel or AMD Chips",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
