import 'dart:io';

import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/widgets/dialog_name_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SaveFile extends StatelessWidget {
  const SaveFile({super.key});

  @override
  Widget build(BuildContext context) {
    final filaProvider = Provider.of<FileProvider>(context, listen: false);
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    Future<String?> _getFileNameFromUser() async {
      // Crea un diálogo de alerta para que el usuario ingrese el nombre del archivo
      return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return DialogNameFile(
            filaProvider: filaProvider,
            dataProvider: dataProvider,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My aplication'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () => filaProvider.saveFile(_getFileNameFromUser()),
              child: const Text('Guardar File')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, 'select_file'),
              child: const Text('Abrir file')),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, 'mostrar'),
              child: const Text('Mostrar contenido')),
        ],
      ),
    );
  }
}
