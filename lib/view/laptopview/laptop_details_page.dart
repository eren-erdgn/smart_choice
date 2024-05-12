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
        title: const Text('Laptop Özellikleri'),
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
              buildLaptopDetail('Ekran Yenileme Hızı', 'ekran_yenileme_hizi'),
              buildLaptopDetail('İşlemci Çekirdeği', 'islemci_cekirdegi'),
              buildLaptopDetail(
                  'İşlemci Temel Frekans', 'islemci_temel_frekans'),
              buildLaptopDetail('Sanal Çekirdek', 'sanal_cekirdek'),
              buildLaptopDetail('İşlemci Önbellek', 'islemci_onbellek'),
              buildLaptopDetail('Ürün Serisi', 'urun_serisi'),
              buildLaptopDetail('Dahili Grafik Modeli', 'dahili_grafik_modeli'),
              buildLaptopDetail('Ürün Ailesi', 'urun_ailesi'),
              buildLaptopDetail('İşletim Sistemi', 'isletim_sistemi'),
              buildLaptopDetail('Renk', 'renk'),
              buildLaptopDetail('Ağırlık', 'agirlik'),
              buildLaptopDetail('Bellek RAM', 'bellek_ram'),
              buildLaptopDetail(
                  'Sabit Disk SSD Boyutu', 'sabit_disk_ssd_boyutu'),
              buildLaptopDetail('Wifi Teknolojisi', 'wifi_teknolojisi'),
              buildLaptopDetail('İşlemci Modeli', 'islemci_modeli'),
              buildLaptopDetail('Pil Gücü', 'pil_gucu'),
              buildLaptopDetail(
                  'Bluetooth Özellikleri', 'bluetooth_ozellikleri'),
              buildLaptopDetail(
                  'Ekran Çözünürlük Biçimi', 'ekran_cozunurluk_bicimi'),
              buildLaptopDetail('Ekran Boyutu', 'ekran_boyutu'),
              buildLaptopDetail('Ekran Çözünürlüğü', 'ekran_cozunurlugu'),
              buildLaptopDetail('Panel Tipi', 'panel_tipi'),
            ] else if (widget.laptopCpu == 'laptops') ...[
              buildLaptopDetail('Ekran Yenileme Hızı', 'ekran_yenileme_hizi'),
              buildLaptopDetail('İşlemci Çekirdeği', 'islemci_cekirdegi'),
              buildLaptopDetail(
                  'İşlemci Artırılmış Frekans', 'islemci_artirilmis_frekans'),
              buildLaptopDetail(
                  'İşlemci Temel Frekans', 'islemci_temel_frekans'),
              buildLaptopDetail('Sanal Çekirdek', 'sanal_cekirdek'),
              buildLaptopDetail('İşlemci Önbellek', 'islemci_onbellek'),
              buildLaptopDetail('GPU Modeli', 'gpu_modeli'),
              buildLaptopDetail('Ürün Serisi', 'urun_serisi'),
              buildLaptopDetail('Ürün Ailesi', 'urun_ailesi'),
              buildLaptopDetail('İşletim Sistemi', 'isletim_sistemi'),
              buildLaptopDetail('Renk', 'renk'),
              buildLaptopDetail('Ağırlık', 'agirlik'),
              buildLaptopDetail('Bellek RAM', 'bellek_ram'),
              buildLaptopDetail('Bellek Türü', 'bellek_turu'),
              buildLaptopDetail(
                  'Sabit Disk SSD Boyutu', 'sabit_disk_ssd_boyutu'),
              buildLaptopDetail('Wifi Teknolojisi', 'wifi_teknolojisi'),
              buildLaptopDetail('İşlemci', 'islemci'),
              buildLaptopDetail('Pil Gücü', 'pil_gucu'),
              buildLaptopDetail(
                  'Bluetooth Özellikleri', 'bluetooth_ozellikleri'),
              buildLaptopDetail(
                  'Ekran Çözünürlük Biçimi', 'ekran_cozunurluk_bicimi'),
              buildLaptopDetail('Ekran Boyutu', 'ekran_boyutu'),
              buildLaptopDetail('Ekran Çözünürlüğü', 'ekran_cozunurlugu'),
            ],
          ],
        ),
      ),
    );
  }
}
