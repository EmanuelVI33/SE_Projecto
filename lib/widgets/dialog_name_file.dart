import 'package:archivos_prueba/providers/data_provider.dart';
import 'package:archivos_prueba/providers/file_provider.dart';
import 'package:archivos_prueba/widgets/dialog_change_var.dart';
import 'package:archivos_prueba/widgets/dialog_custom.dart';
import 'package:flutter/material.dart';

class DialogNameFile extends StatelessWidget {
  const DialogNameFile({
    Key? key,
    required this.filaProvider,
    required this.dataProvider,
  }) : super(key: key);

  final FileProvider filaProvider;
  final DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nombre del archivo'),
      content: TextField(
        autofocus: true,
        onChanged: (String value) {
          filaProvider.fileName = value;
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Guardar'),
          onPressed: () async {
            String fileName = filaProvider.fileName;
            int pos = fileName.lastIndexOf('.');
            String ext = fileName.substring(pos + 1, fileName.length);
            print(ext);
            if (ext != 'txt') {
              Navigator.pop(context);
              await showDialog(
                context: context,
                builder: (context) => const DialogCustom(
                    title: 'Extensión incorecta',
                    content: 'Los archivos tiene extenxió .txt'),
              );
              return;
            }
            filaProvider.writeToFile(dataProvider.toStr());
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
