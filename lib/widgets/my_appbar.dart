import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/widgets/dialog_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    final String mapText = Provider.of<DataProvider>(context).toStr();
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.indigo,
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DialogGuardar(
                title: '¿Desear guardar los cambios?',
                function: () {
                  fileProvider.writeToFile(mapText);
                  Navigator.pop(context);
                },
              ),
            );
          },
          icon: const Icon(Icons.save),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DialogGuardar(
                title: '¿Quieres cerrar el archivo?',
                function: () {
                  fileProvider.fileName = '';
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            );
          },
          icon: const Icon(Icons.close_rounded),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DialogGuardar extends StatelessWidget {
  const DialogGuardar({super.key, required this.function, required this.title});

  final String title;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        ElevatedButton(onPressed: function, child: const Text('Aceptar')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar')),
      ],
    );
  }
}
