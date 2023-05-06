import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/data_provider.dart';
import 'package:archivos_prueba/providers/form_variable_provider.dart';
import 'package:archivos_prueba/widgets/dialog_add_form.dart';
import 'package:archivos_prueba/widgets/dialog_add_var.dart';
import 'package:archivos_prueba/widgets/my_appbar.dart';
import 'package:archivos_prueba/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MostrarVariables extends StatelessWidget {
  const MostrarVariables({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(title: 'Variables'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Variables',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const DialogAddVar(),
                      );
                    },
                    icon: const Icon(
                      Icons.add_box_rounded,
                      size: 35,
                      color: Colors.blueAccent,
                    )),
              ],
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigo,
                ),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: _ListVariable(dataProvider: dataProvider)),
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

class _ListVariable extends StatelessWidget {
  final DataProvider dataProvider;

  const _ListVariable({super.key, required this.dataProvider});

  @override
  Widget build(BuildContext context) {
    final variables = dataProvider.getVariables();
    if (variables.isEmpty) {
      return const Text(
        'No existe ninguna variable',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }

    return SizedBox(
      height: variables.length.toDouble() * 70,
      child: ListView.builder(
        itemCount: variables.length,
        itemBuilder: (context, index) {
          final List<MapEntry<String, dynamic>> lista =
              variables.entries.toList();
          final Map<String, dynamic> variable = lista[index].value;
          String key = lista[index].key;
          String text = variable["tipo"] ? 'Numérica' : 'Escalar';
          var textStyle =
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
          return ListTile(
            title: Text(
              '${variable["name"]}',
              style: textStyle,
            ),
            subtitle: Text(
              '($text)',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            trailing: TextButton.icon(
                onPressed: () {
                  final formVariable =
                      Provider.of<FormVariableProvider>(context, listen: false);
                  if (variable['tipo']) {
                    // Es numerica
                    Numeric myVariable = Numeric.fromJson(variable);
                    formVariable.id = myVariable.id.toString();
                    formVariable.name = myVariable.name;
                    formVariable.valor = myVariable.valor ?? '';
                    formVariable.rango = myVariable.rango ?? '';
                    // Para el radio button
                    formVariable.tipoVariable = 'numerica';
                  } else {
                    // Es escalar
                    Scale myVariable = Scale.fromJson(variable);
                    formVariable.id = myVariable.id.toString();
                    formVariable.name = myVariable.name;
                    formVariable.valores = myVariable.valores ?? [];
                    if (formVariable.valores.isNotEmpty) {
                      formVariable.sizeValores =
                          formVariable.valores.length.toDouble() * 50;
                    }

                    // Para el radio button
                    formVariable.tipoVariable = 'escalar';
                  }

                  Navigator.pushNamed(context, 'add_variable');
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.lightBlue,
                ),
                label: const Text(
                  'Agregar valores',
                  style: TextStyle(fontSize: 10, color: Colors.lightBlue),
                )),
            leading: Text(
              '${index + 1}',
              style: textStyle,
            ),
            onTap: () async {},
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => DialogDeleteVar(
                  title: '¿Deseas eliminar esta variable?',
                  function: () {
                    dataProvider.deleteVar(key);
                    Navigator.pop(context);
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
