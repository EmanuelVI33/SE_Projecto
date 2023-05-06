import 'dart:io';

import 'package:archivos_prueba/providers/file_provider.dart';
import 'package:archivos_prueba/widgets/dialog_confirmation.dart';
import 'package:archivos_prueba/widgets/dialog_delete_file.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class SelectFile extends StatelessWidget {
  const SelectFile({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);

    return FutureBuilder(
      future: fileProvider.getFiles(),
      builder: (BuildContext context,
          AsyncSnapshot<List<FileSystemEntity>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text('Error al obtener los archivos');
        } else {
          // Lista de archivos
          final files = snapshot.data!;

          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20))),
              height: 500,
              child: files.isEmpty
                  ? const Center(
                      child: Text(
                        'Carpeta vacia',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Archov actual
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            print('Nombre archivo ${fileProvider.fileName}');

                            await showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                    title: 'Deseas abrir este archivo?',
                                    message: 'Abrir ${fileProvider.fileName}',
                                    buttonText: '');
                              },
                            );
                          },
                          onLongPress: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return DialogDeleteFile(
                                      filename: fileName(file.path),
                                      funcion: fileProvider.deleteFile);
                                });
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

String fileName(String path) {
  int pos = path.lastIndexOf("/");
  return path.substring(pos + 1);
}
