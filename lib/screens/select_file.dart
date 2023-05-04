import 'dart:io';

import 'package:archivos_prueba/providers/file_provider.dart';
import 'package:archivos_prueba/widgets/dialog_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SelectFile extends StatelessWidget {
  const SelectFile({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);

    return FutureBuilder(
      future: _getFiles(),
      builder: (BuildContext context,
          AsyncSnapshot<List<FileSystemEntity>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error al obtener los archivos');
        } else {
          final files = snapshot.data!;

          if (files.isEmpty) return const Text('No existen archivos');

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              height: 500,
              child: ListView.builder(
                itemCount: files.length,
                itemBuilder: (BuildContext context, int index) {
                  final file = files[index];
                  return ListTile(
                    title: Container(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${index + 1}.- ${fileName(file.path)}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              textAlign: TextAlign.left,
                            ),
                            const Icon(
                              Icons.file_copy_outlined,
                              color: Colors.white,
                              size: 40,
                            )
                          ],
                        )),
                    onTap: () async {
                      fileProvider.fileName = fileName(file.path);

                      await showDialog(
                        context: context,
                        builder: (context) {
                          return CustomDialog(
                              title: 'Deseas abrir este archivo?',
                              message:
                                  'Abrir ${fileName(fileProvider.fileName)}',
                              buttonText: '');
                        },
                      );
                    },
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}

bool pathEndsWithExtension(String path) {
  final RegExp regExp = RegExp(r'^\/.+\/[^\/]+\.\w+$');
  return regExp.hasMatch(path);
}

String fileName(String path) {
  int pos = path.lastIndexOf("/");
  return path.substring(pos + 1);
}

Future<List<FileSystemEntity>> _getFiles() async {
  final directory = await getApplicationDocumentsDirectory();
  final List<FileSystemEntity> filesDirectory = directory.listSync();
  final List<FileSystemEntity> files = [];
  for (FileSystemEntity file in filesDirectory) {
    if (file is File && pathEndsWithExtension(file.path)) {
      files.add(file);
    }
  }

  return files;
}
