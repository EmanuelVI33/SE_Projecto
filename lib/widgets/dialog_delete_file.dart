import 'package:flutter/material.dart';

class DialogDeleteFile extends StatelessWidget {
  const DialogDeleteFile(
      {super.key, required this.filename, required this.funcion});

  final String filename;
  final Function funcion;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('¿Deseas eliminar este archivo?'),
      icon: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.red,
      ),
      actions: [
        ElevatedButton(
          child: const Text('Si'),
          onPressed: () async {
            funcion(filename);
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: const Text('No'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
