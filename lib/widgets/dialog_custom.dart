import 'package:flutter/material.dart';

class DialogCustom extends StatelessWidget {
  const DialogCustom({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      icon: const Icon(
        Icons.warning,
        color: Colors.yellow,
        size: 30,
      ),
      content: Text(
        content,
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
