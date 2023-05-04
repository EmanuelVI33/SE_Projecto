import 'package:archivos_prueba/screens/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Base de conocimientos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const SelectFile(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar homeAppBar() {
    return AppBar(
      title: const Text(
        'Sistemas experto',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.indigo,
      actions: [],
    );
  }
}
