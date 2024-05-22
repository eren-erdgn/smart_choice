import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LaptopDetailsPage extends StatefulWidget {
  final Map<String, dynamic> laptop;
  final String laptopCpu;

  const LaptopDetailsPage(
      {super.key, required this.laptop, required this.laptopCpu});

  @override
  State<LaptopDetailsPage> createState() => _LaptopDetailsPageState();
}

class _LaptopDetailsPageState extends State<LaptopDetailsPage> {
  bool isFavorite = false;
  Widget buildLaptopDetail(String title, String key) {
    return ListTile(
      title: Text(title),
      subtitle: Text(widget.laptop[key]),
    );
  }
  void initState() {
    super.initState();
    checkFavorite();
  }
  Future<void> checkFavorite() async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    final myArrayField = userDoc.data()!['myArrayField'] as List<dynamic>;
    setState(() {
      isFavorite = myArrayField.contains(widget.laptop['laptop_id']);
    });
  }
  Future<void> appendToArray(dynamic element) async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'myArrayField': FieldValue.arrayUnion([element]),
    });
  }
  Future<void> removeFromArray(dynamic element) async {
    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
      'myArrayField': FieldValue.arrayRemove([element]),
    });
  }
  Future<void> toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });
    if (isFavorite) {
      await appendToArray(widget.laptop['laptop_id']); // Favorilere ekle
    } else {
      await removeFromArray(widget.laptop['laptop_id']); // Favorilerden kaldır
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laptop Specs'),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.memory(
                widget.laptop['foto'],
                width: 300,
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            Text('Model: ${widget.laptop['model_ismi']}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('Fiyat: ${widget.laptop['fiyat']} TL',
                style: const TextStyle(fontSize: 16)),
            const Divider(),
            const Text('Özellikler',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            if (widget.laptopCpu == 'laptopsmac') ...[
              buildLaptopDetail('Refresh Rate', 'ekran_yenileme_hizi'),
              buildLaptopDetail('Cpu Core', 'islemci_cekirdegi'),
              buildLaptopDetail(
                  'Processor Base Frequency', 'islemci_temel_frekans'),
              buildLaptopDetail('Virtual Core', 'sanal_cekirdek'),
              buildLaptopDetail('CPU Cache', 'islemci_onbellek'),
              buildLaptopDetail('Sub Series', 'urun_serisi'),
              buildLaptopDetail('GPU Model', 'dahili_grafik_modeli'),
              buildLaptopDetail('Series', 'urun_ailesi'),
              buildLaptopDetail('OS', 'isletim_sistemi'),
              buildLaptopDetail('Color', 'renk'),
              buildLaptopDetail('Weight', 'agirlik'),
              buildLaptopDetail('RAM Size', 'bellek_ram'),
              buildLaptopDetail(
                  'SSD Size', 'sabit_disk_ssd_boyutu'),
              buildLaptopDetail('Wifi', 'wifi_teknolojisi'),
              buildLaptopDetail('CPU Model', 'islemci_modeli'),
              buildLaptopDetail('Battery Power', 'pil_gucu'),
              buildLaptopDetail(
                  'Bluetooth', 'bluetooth_ozellikleri'),
              buildLaptopDetail(
                  'Screen Resolution Format', 'ekran_cozunurluk_bicimi'),
              buildLaptopDetail('Screen Size', 'ekran_boyutu'),
              buildLaptopDetail('Screen Resolution', 'ekran_cozunurlugu'),
              buildLaptopDetail('Panel Type', 'panel_tipi'),
            ] else if (widget.laptopCpu == 'laptops') ...[
              buildLaptopDetail('Refresh Rate', 'ekran_yenileme_hizi'),
              buildLaptopDetail('Cpu Core', 'islemci_cekirdegi'),
              buildLaptopDetail(
                  'Processor Increased Frequency', 'islemci_artirilmis_frekans'),
              buildLaptopDetail(
                  'Processor Base Frequency', 'islemci_temel_frekans'),
              buildLaptopDetail('Virtual Core', 'sanal_cekirdek'),
              buildLaptopDetail('CPU Cache', 'islemci_onbellek'),
              buildLaptopDetail('GPU Model', 'gpu_modeli'),
              buildLaptopDetail('Sub Series', 'urun_serisi'),
              buildLaptopDetail('Series', 'urun_ailesi'),
              buildLaptopDetail('OS', 'isletim_sistemi'),
              buildLaptopDetail('Color', 'renk'),
              buildLaptopDetail('Weight', 'agirlik'),
              buildLaptopDetail('RAM Size', 'bellek_ram'),
              buildLaptopDetail('RAM Type', 'bellek_turu'),
              buildLaptopDetail(
                  'SSD Size', 'sabit_disk_ssd_boyutu'),
              buildLaptopDetail('Wifi', 'wifi_teknolojisi'),
              buildLaptopDetail('CPU', 'islemci'),
              buildLaptopDetail('Battery Power', 'pil_gucu'),
              buildLaptopDetail(
                  'Bluetooth', 'bluetooth_ozellikleri'),
              buildLaptopDetail(
                  'Screen Resolution Format', 'ekran_cozunurluk_bicimi'),
              buildLaptopDetail('Screen Size', 'ekran_boyutu'),
              buildLaptopDetail('Screen Resolution', 'ekran_cozunurlugu'),
            ],
          ],
        ),
      ),
    );
  }
}
