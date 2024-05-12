import 'package:smart_choice/view/laptopview/laptops_page.dart';
import 'package:flutter/material.dart';

class OsChoicePage extends StatefulWidget {
  const OsChoicePage({super.key});

  @override
  State<OsChoicePage> createState() => _OsChoicePageState();
}

class _OsChoicePageState extends State<OsChoicePage> {
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
                      builder: (context) => const LaptopsPage(laptopCpu: 'laptopsmac',),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(100),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text("Apple Silicon Chips")),
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
                      builder: (context) => const LaptopsPage(laptopCpu: 'laptops',),
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
                    child: Text("Intel or AMD Chips"),
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
