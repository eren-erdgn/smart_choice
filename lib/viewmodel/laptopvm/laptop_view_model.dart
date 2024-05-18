import 'dart:async';
import 'dart:io' as io;

import 'package:smart_choice/model/laptop_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class LaptopViewModel{

  final _laptopModels = LaptopModel();

  List<Map<String, dynamic>> get getLaptops {
    return _laptopModels.getLaptops;
  }

  Future<void> fetchLaptops(String laptopList) async {
    String dbPath = await _copy('assets/laptop_test(1).db');
    Database database = await openDatabase(dbPath);
    
    List<Map<String, dynamic>> queryResult = await database.rawQuery(
      'SELECT * FROM $laptopList');
    
    _laptopModels.setLaptops = queryResult;

    await database.close();
  }
  
  
  Future<String> _copy(String assetPath) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$assetPath';
    await io.Directory(dirname(path)).create(recursive: true);
    final file = io.File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(assetPath);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }
}