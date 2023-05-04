import 'package:archivos_prueba/providers/file_provider.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mostrar extends StatelessWidget {
  const Mostrar({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Mostrar',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('File name: ${fileProvider.fileName}'),
            Text('File content: ${dataProvider.toStr()}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fileProvider.readFromFile,
              child: const Text('Read from file'),
            ),
            ElevatedButton(
              onPressed: () => fileProvider.writeToFile(dataProvider.toStr()),
              child: const Text('Write file'),
            ),
          ],
        ),
      ),
    );
  }
}
