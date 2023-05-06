import 'package:archivos_prueba/providers/data_provider.dart';
import 'package:archivos_prueba/providers/file_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);

    void initData() async {
      // lee del archivo
      dataProvider.map = await fileProvider.readFromFileToMap();
      dataProvider.initVariable();
    }

    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Si'),
          onPressed: () async {
            initData();
            Navigator.popAndPushNamed(context, 'menu');
          },
        ),
        ElevatedButton(
          child: Text('No'),
          onPressed: () {
            fileProvider.fileName = '';
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
