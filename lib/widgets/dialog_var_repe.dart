import 'package:flutter/material.dart';

class DialogVarRepe extends StatelessWidget {
  const DialogVarRepe({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.warning,
        color: Colors.yellow,
      ),
      title: Text('Nombre de variable repetida'),
      content: Text('Verifique la lista de variables'),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context), child: Text('Ok')),
      ],
    );
  }
}
