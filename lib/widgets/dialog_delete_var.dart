import 'package:archivos_prueba/providers/providers.dart';
import 'package:flutter/material.dart';

class DialogDeleteVar extends StatelessWidget {
  const DialogDeleteVar(
      {super.key, required this.function, required this.title});

  final String title;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
      icon: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.red,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: size.width * 0.25,
              child:
                  ElevatedButton(onPressed: function, child: const Text('Si')),
            ),
            SizedBox(
              width: size.width * 0.25,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
            ),
          ],
        )
      ],
    );
  }
}
