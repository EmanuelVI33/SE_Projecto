import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/ui/auth_decoration.dart';
import 'package:archivos_prueba/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddVar extends StatelessWidget {
  const DialogAddVar({super.key});

  @override
  Widget build(BuildContext context) {
    final formVariable = Provider.of<FormVariableProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);

    const textStyle = TextStyle(
      fontSize: 12,
    );
    return AlertDialog(
      title: const Text(
        'Añadir variable',
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.authInputDecorations(
                  hintText: '',
                  labelText: 'Name',
                  prefixIcon: Icons.abc_rounded),
              onChanged: (value) => formVariable.name = value,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Radio(
                        value: 'numerica',
                        groupValue: formVariable.tipoVariable,
                        onChanged: (value) =>
                            formVariable.tipoVariable = value),
                    const Text(
                      'Numérica',
                      style: textStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 'escalar',
                        groupValue: formVariable.tipoVariable,
                        onChanged: (value) =>
                            formVariable.tipoVariable = value),
                    const Text(
                      'Escalar',
                      style: textStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            ElevatedButton(
                onPressed: () {
                  final List<String> listVar = dataProvider.listVar;
                  print('Lista de variables $listVar');
                  print('Mapa ${dataProvider.map}');

                  if (listVar.contains(formVariable.name)) {
                    showDialog(
                      context: context,
                      builder: (context) => const DialogVarRepe(),
                    );
                    return;
                  }

                  if (formVariable.tipoVariable == 'numerica') {
                    Numeric numeric = Numeric(
                        id: dataProvider.nroVariable, name: formVariable.name);
                    dataProvider.addNumeric(numeric);
                  } else {
                    Scale escalar = Scale(
                        id: dataProvider.nroVariable, name: formVariable.name);
                    dataProvider.addScale(escalar);
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Añadir',
                  style: textStyle,
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancelar',
                  style: textStyle,
                )),
          ],
        )
      ],
    );
  }
}
