import 'package:archivos_prueba/providers/file_provider.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    // final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: MyAppBar(
        title: fileProvider.fileName,
      ),
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, 'add_variable'),
                child: Text('Añadir Variable')),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, 'mostrar'),
                child: Text('Mostrar contenido')),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, 'mostrar'),
                child: Text('Mostrar contenido')),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, 'add_rule'),
                child: Text('Add rule')),
          ],
        ),
      ),
    );
  }
}
