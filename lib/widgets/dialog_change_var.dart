import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/data_provider.dart';
import 'package:archivos_prueba/providers/form_variable_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogChangeVar extends StatelessWidget {
  const DialogChangeVar(
      {super.key,
      required this.isEscalar,
      required this.idVariable,
      required this.name,
      required this.reglas});

  final int idVariable;
  final String name;
  final bool isEscalar;
  final List<String> reglas;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final formVariable = Provider.of<FormVariableProvider>(context);
    String text = isEscalar
        ? 'Cambiar de escalar a numérica'
        : 'Cambiar de numérica a escalar';
    return AlertDialog(
      title: const Text('¿Estas seguro de modificar la variable?'),
      content: SingleChildScrollView(
        child: Container(
          width: 200,
          height: 100,
          child: ListView.builder(
            itemCount: reglas.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Regla ${reglas[index]}'),
              );
            },
          ),
        ),
      ),
      icon: const Icon(
        Icons.warning_rounded,
        size: 20,
        color: Colors.yellowAccent,
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              dataProvider.deleteListInVar(idVariable.toString());
              if (isEscalar) {
                Numeric numeric = Numeric(id: idVariable, name: name);
                dataProvider.addNumeric(numeric);
                formVariable.tipoVariable = 'numerica';
              } else {
                Scale scale = Scale(id: idVariable, name: name);
                dataProvider.addScale(scale);
                formVariable.tipoVariable = 'escalar';
              }
              Navigator.pop(context, true);
            },
            child: Text('Si')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text('No')),
      ],
    );
  }
}
