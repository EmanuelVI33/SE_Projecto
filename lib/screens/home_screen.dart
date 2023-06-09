import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/screens/screens.dart';
import 'package:archivos_prueba/widgets/dialog_name_file.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: homeAppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Base de conocimientos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                  IconButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return DialogNameFile(
                                filaProvider: fileProvider,
                                dataProvider: dataProvider);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add_box_rounded,
                        size: 30,
                        color: Colors.blueAccent,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const SelectFile(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Mantener presionado para eliminar',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black26),
                  ),
                  Icon(
                    Icons.delete,
                    size: 20,
                    color: Colors.redAccent,
                  ),
                ],
              )
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
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.indigo,
      actions: [],
    );
  }
}
