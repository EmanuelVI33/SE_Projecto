import 'package:flutter/material.dart';

class DialogRule extends StatelessWidget {
  const DialogRule({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Regla incorecto'),
      icon: const Icon(
        Icons.warning,
        color: Colors.yellow,
        size: 30,
      ),
      content: const Text(
        'Verifique la premisa o la conclusión',
        maxLines: 3,
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Container(
              decoration: const BoxDecoration(color: Colors.blue),
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ))
      ],
    );
  }
}
