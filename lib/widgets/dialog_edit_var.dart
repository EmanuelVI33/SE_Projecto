import 'package:archivos_prueba/providers/data_provider.dart';
import 'package:archivos_prueba/providers/form_variable_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogEditVar extends StatelessWidget {
  final String identVar;
  final FormVariableProvider formVar;
  const DialogEditVar({
    super.key,
    required this.identVar,
    required this.formVar,
  });

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    return AlertDialog(
      title: Text(
        '¿Deseas editar la variable $identVar?',
        textAlign: TextAlign.center,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
                // clipBehavior: Clip.,
                onPressed: () {
                  Map<String, dynamic> variable = dataProvider.map[identVar];
                  bool isNumeric = variable['tipo'];
                  formVar.ident = identVar;
                  if (isNumeric) {
                    formVar.valor = variable['valor'];
                    formVar.rango = variable['rango'];
                    formVar.tipoVariable = 'numerica';
                  } else {
                    formVar.valores = variable['valores'];
                    formVar.tipoVariable = 'escalar';
                  }

                  Navigator.pop(context);
                },
                child: Text('Si')),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No')),
          ],
        )
      ],
    );
  }
}
