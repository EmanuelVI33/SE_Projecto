import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileProvider extends ChangeNotifier {
  String _fileName = '';
  String _content = '';

  String get fileName => _fileName;

  set fileName(String file) => _fileName = file;

  String get content => _content;

  set content(String s) => _content = s;

  Future<File> getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$fileName');
  }

  Future<void> writeToFile(String text) async {
    print(text);
    final file = await getLocalFile();
    await file.writeAsString(text);
    notifyListeners();
  }

  Future<String> readFromFile() async {
    try {
      final file = await getLocalFile();
      notifyListeners();
      return await file.readAsString();
    } catch (e) {
      return '';
    }
  }

  Future<Map<String, dynamic>> readFromFileToMap() async {
    String data = await readFromFile();
    return await jsonDecode(data);
  }

  Future<void> saveFile(Future<String?> dialog) async {
    // Obtener el directorio de documentos del dispositivo
    final directory = await getApplicationDocumentsDirectory();

    await dialog;

    // Crear y guardar el archivo
    final file = File('${directory.path}/$fileName');

    // Escribe el contenido en el archivo
    await file.writeAsString('Este es el contenido del archivo');

    // Mostrar un mensaje de confirmación al usuario
    // que se guardó el archivo correctamente
    // y que está en el directorio de documentos
  }
}
