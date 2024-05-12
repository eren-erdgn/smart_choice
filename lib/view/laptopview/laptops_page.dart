import 'package:smart_choice/view/laptopview/laptop_details_page.dart';
import 'package:smart_choice/viewmodel/laptopvm/laptop_view_model.dart';
import 'package:flutter/material.dart';

class LaptopsPage extends StatefulWidget {
  const LaptopsPage({super.key, required this.laptopCpu});

  final String laptopCpu;

  @override
  State<LaptopsPage> createState() => _LaptopsPageState();
}

class _LaptopsPageState extends State<LaptopsPage> {
  final _laptopvm = LaptopViewModel();
  List<Map<String, dynamic>> laptops = [];
  List<Map<String, dynamic>> selectedLaptops = [];
  bool isFilterExpanded = false;
  bool isSortExpanded = false;
  Map<String, List<int>> filterIndexMap = {};

  @override
  void initState() {
    super.initState();
    _fetchLaptops();
  }

  Future<void> _fetchLaptops() async {
    await _laptopvm.fetchLaptops(widget.laptopCpu);
    setState(() {
      laptops = _laptopvm.getLaptops;
      selectedLaptops = List.from(laptops);
    });
  }

  void _showFilterDialog(String attribute) async {
    List<String> attributeList = _getUniqueItems(attribute);
    List<int> filterIndex = filterIndexMap[attribute] ?? [];
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(attribute),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  children: attributeList.map((attribute) {
                    int index = attributeList.indexOf(attribute);
                    bool isChecked = filterIndex.contains(index);
                    return CheckboxListTile(
                      title: Text(attribute),
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              isChecked = value;
                              filterIndex.add(index);
                            } else {
                              isChecked = value;
                              filterIndex.remove(index);
                            }
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                _applyFilter(attribute, filterIndex);
                Navigator.pop(context);
              },
              child: const Text('Uygula'),
            ),
          ],
        );
      },
    );
  }

  List<String> _getUniqueItems(String key) {
    Set<String> keySet = {};
    for (var laptop in laptops) {
      keySet.add(laptop[key]);
    }
    return keySet.toList();
  }

  void _applyFilter(String key, List<int> filterIndex) {
    filterIndexMap[key] = filterIndex;
    selectedLaptops = [];
    if (filterIndexMap.values.every((element) => element.isEmpty)) {
      selectedLaptops = List.from(laptops);
      setState(() {});
      return;
    }
    // Seçili tüm filtreleri al
    List<String> selectedAttributes = [];
    for (var entry in filterIndexMap.entries) {
      for (var index in entry.value) {
        selectedAttributes.add(_getUniqueItems(entry.key)[index]);
      }
    }

    // Her bir laptop için filtreleri kontrol et
    for (var laptop in laptops) {
      bool add = true;
      for (var entry in filterIndexMap.entries) {
        if(entry.value.isEmpty) continue;
        String selectedAttribute = laptop[entry.key];
        if (!selectedAttributes.contains(selectedAttribute)) {
          add = false;
          break;
        }
      }
      if (add) {
        selectedLaptops.add(laptop);
      }
    }
    setState(() {});
  }

  void _applySortingForPrice(String attribute, {bool ascending = true}) {
    selectedLaptops.sort((a, b) {
      double aValue = _parsePrice(a[attribute]);
      double bValue = _parsePrice(b[attribute]);
      if (ascending) {
        return aValue.compareTo(bValue);
      } else {
        return bValue.compareTo(aValue);
      }
    });
    setState(() {});
  }

  double _parsePrice(String priceString) {
    if(priceString.isEmpty) return 0.0;
    // "TL" işaretini kaldır
    priceString = priceString.replaceAll("TL", "").trim();
    // Nokta ve virgül işaretlerini düzgünleştir
    priceString = priceString.replaceAll(".", "").replaceAll(",", ".");
    // String'i double türüne dönüştür
    return double.parse(priceString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laptop Listesi'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.filter_alt),
                onPressed: () {
                  setState(() {
                    isFilterExpanded = !isFilterExpanded;
                    if (isSortExpanded) {
                      isSortExpanded = false;
                    }
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: () {
                  setState(() {
                    isSortExpanded = !isSortExpanded;
                    if (isFilterExpanded) {
                      isFilterExpanded = false;
                    }
                  });
                },
              ),
            ],
          ),
          if (isFilterExpanded)
            SizedBox(
              height: 50,
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                scrollDirection: Axis.horizontal,
                children: [
                  ElevatedButton(
                    onPressed: () => _showFilterDialog('renk'),
                    child: const Text('Renk'),
                  ),
                  ElevatedButton(
                    onPressed: () => _showFilterDialog('ekran_yenileme_hizi'),
                    child: const Text('Ekran Yenileme Hızı'),
                  ),
                  ElevatedButton(
                    onPressed: () => _showFilterDialog('bellek_ram'),
                    child: const Text('Ram Boyutu'),
                  ),
                  ElevatedButton(
                    onPressed: () => _showFilterDialog('sabit_disk_ssd_boyutu'),
                    child: const Text('SSD Boyutu'),
                  ),
                  ElevatedButton(
                    onPressed: () => _showFilterDialog('ekran_boyutu'),
                    child: const Text('Ekran Boyutu'),
                  ),
                  ElevatedButton(
                    onPressed: () => _showFilterDialog('urun_ailesi'),
                    child: const Text('Ürün Ailesi'),
                  ),
                ],
              ),
            ),
          if (isSortExpanded)
            SizedBox(
              height: 50,
              child: ListView(
                padding: const EdgeInsets.all(10.0),
                scrollDirection: Axis.horizontal,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _applySortingForPrice('fiyat', ascending: true),
                    child: const Text('Fiyat Artan'),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _applySortingForPrice('fiyat', ascending: false),
                    child: const Text('Fiyat Azalan'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedLaptops.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.memory(
                      selectedLaptops[index]['foto'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      selectedLaptops[index]['model_ismi'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fiyat: ${selectedLaptops[index]['fiyat']}'),
                        Text(
                            'Ekran Boyutu: ${selectedLaptops[index]['ekran_boyutu']}'),
                        Text(
                            'Çözünürlük: ${selectedLaptops[index]['ekran_cozunurlugu']}'),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LaptopDetailsPage(
                            laptop: selectedLaptops[index],
                            laptopCpu: widget.laptopCpu,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
