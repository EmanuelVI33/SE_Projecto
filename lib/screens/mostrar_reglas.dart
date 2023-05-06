import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/data_provider.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/widgets/dialog_add_var.dart';
import 'package:archivos_prueba/widgets/dialog_delete_var.dart';
import 'package:archivos_prueba/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MostrarReglas extends StatelessWidget {
  const MostrarReglas({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(title: 'Reglas'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Reglas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'add_rule');
                    },
                    icon: const Icon(
                      Icons.add_box_rounded,
                      size: 30,
                      color: Colors.blueAccent,
                    )),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigo,
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: _ListReglas(dataProvider: dataProvider)),
            SizedBox(
              height: 15,
            ),
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
    );
  }
}

class _ListReglas extends StatelessWidget {
  final DataProvider dataProvider;

  const _ListReglas({super.key, required this.dataProvider});

  @override
  Widget build(BuildContext context) {
    final reglas = dataProvider.reglas;
    // final listVar = dataProvider.listVar;
    if (reglas.isEmpty) {
      return const Text(
        'No existe ninguna variable',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }

    return SizedBox(
      height: reglas.length.toDouble() * 70,
      child: ListView.builder(
        itemCount: reglas.length,
        itemBuilder: (context, index) {
          final List<MapEntry<String, dynamic>> lista = reglas.entries.toList();
          final Map<String, dynamic> variable = lista[index].value;
          String key = lista[index].key;
          return ListTile(
            title: Text(
              'Regla [${key}]',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            trailing: TextButton.icon(
                onPressed: () {
                  final formRules =
                      Provider.of<FormRuleProvider>(context, listen: false);
                  final reglas =
                      Provider.of<DataProvider>(context, listen: false).reglas;
                  Regla regla = Regla.fromJson(reglas[key]);
                  formRules.id = regla.id;
                  formRules.premisa = regla.premisa;
                  formRules.conclusion = regla.hecho;

                  Navigator.pushNamed(context, 'add_rule');
                },
                icon: const Icon(Icons.edit),
                label: const Text(
                  'Editar regla',
                  style: TextStyle(fontSize: 12),
                )),
            leading: Text('${index + 1} .-'),
            onTap: () async {},
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => DialogDeleteVar(
                  title: '¿Deseas eliminar esta regla?',
                  function: () {
                    dataProvider.deleteRule(key);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
