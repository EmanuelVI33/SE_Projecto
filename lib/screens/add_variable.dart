import 'dart:io';
import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/ui/auth_decoration.dart';
import 'package:archivos_prueba/widgets/dialog_change_var.dart';
import 'package:archivos_prueba/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:path_provider/path_provider.dart';

class AddVariable extends StatelessWidget {
  const AddVariable({super.key});

  @override
  Widget build(BuildContext context) {
    final formVariable = Provider.of<FormVariableProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);
    final Map<String, dynamic> variables = dataProvider.getVariables();

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Añadir variable',
      ),
      body: Column(
        children: [
          _LoginForm(
            dataProvider: dataProvider,
            formVariable: formVariable,
          ),
          // _ListVariable(
          //   dataProvider: dataProvider,
          //   formVar: formVariable,
          // )
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final FormVariableProvider formVariable;
  final DataProvider dataProvider;

  const _LoginForm({required this.formVariable, required this.dataProvider});

  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    final Map<String, dynamic> variable = formVariable.variable;
    final size = MediaQuery.of(context).size;
    print('Lista de valores ${formVariable.valores}');

    bool isEscalar = formVariable.tipoVariable == 'escalar';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Form(
        key: formVariable.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Agregar valores',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: formVariable.name,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecorations(
                  hintText: '',
                  labelText: 'Nombre',
                  prefixIcon: Icons.abc_rounded),
              onChanged: (value) => formVariable.name = value,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: isEscalar ? size.width * 0.75 : size.width * 0.95,
                  child: TextFormField(
                      initialValue: formVariable.valor == null
                          ? ''
                          : formVariable.valor.toString(),
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecorations.authInputDecorations(
                          hintText: '',
                          labelText: 'Valor',
                          prefixIcon: Icons.alternate_email_rounded),
                      onChanged: (value) {
                        formVariable.valor = value;
                      }),
                ),
                if (isEscalar) const SizedBox(width: 15),
                if (isEscalar)
                  IconButton(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      onPressed: () {
                        final int length = formVariable.valores.length;
                        formVariable.addValor(formVariable.valor);
                        if (length < formVariable.valores.length &&
                            formVariable.valores.length < 5) {
                          // Incrementa el tamaño, mientras tenga menos de 5 elementos
                          formVariable.sizeValores += 50;
                        }
                      },
                      color: Colors.indigo,
                      icon: const Icon(
                        Icons.add_box,
                        size: 40,
                      )),
              ],
            ),
            const SizedBox(height: 10),
            if (isEscalar)
              SizedBox(
                height: formVariable.sizeValores,
                child: ListView.builder(
                  itemCount: formVariable.valores.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(formVariable.valores[index]),
                    );
                  },
                ),
              ),
            if (formVariable.tipoVariable == 'numerica')
              TextFormField(
                initialValue: formVariable.rango,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.authInputDecorations(
                    hintText: '1:20',
                    labelText: 'Rango',
                    prefixIcon: Icons.alternate_email_rounded),
                onChanged: (value) => formVariable.rango = value,
              ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Radio(
                        value: 'numerica',
                        groupValue: formVariable.tipoVariable,
                        onChanged: (value) async =>
                            await _displayDialog(context, isEscalar, value)),
                    const Text('Numerica'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 'escalar',
                        groupValue: formVariable.tipoVariable,
                        onChanged: (value) async =>
                            await _displayDialog(context, isEscalar, value)),
                    const Text('Escalar'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.deepPurple,
                onPressed: () async {
                  // Obtener variable
                  final variable = dataProvider.variables[formVariable.id];

                  if (variable["name"] != formVariable.name &&
                      dataProvider.existeVar(formVariable.name)) {
                    showDialog(
                      context: context,
                      builder: (context) => const DialogVarRepe(),
                    );
                    return;
                  }

                  if (isEscalar) {
                    Scale escalar = Scale(
                        id: int.parse(formVariable.id),
                        name: formVariable.name,
                        valores: formVariable.valores);

                    dataProvider.addScale(escalar);
                  } else {
                    Numeric numerica = Numeric(
                        id: int.parse(formVariable.id),
                        name: formVariable.name,
                        valor: formVariable.valor,
                        rango: formVariable.rango);

                    dataProvider.addNumeric(numerica);
                  }

                  Navigator.pop(context);

                  // fileProvider.writeToFile(dataProvider.toStr());
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: Text(
                      formVariable.isLoading ? 'Espere' : 'Añadir',
                      style: const TextStyle(color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }

  Future<void> _displayDialog(
      BuildContext context, bool isEscalar, String? value) async {
    await showDialog(
      context: context,
      builder: (context) {
        return DialogChangeVar(
            isEscalar: isEscalar,
            idVariable: int.parse(formVariable.id),
            name: formVariable.name);
      },
    );
  }
}

class _ListVariable extends StatelessWidget {
  final DataProvider dataProvider;
  final FormVariableProvider formVar;

  const _ListVariable(
      {super.key, required this.dataProvider, required this.formVar});

  @override
  Widget build(BuildContext context) {
    final listVar = dataProvider.listVar;
    final map = dataProvider.map;
    return SizedBox(
      height: (listVar.length.toDouble()) * 50,
      child: ListView.builder(
        itemCount: listVar.length,
        itemBuilder: (context, index) {
          bool isNumeric = map[listVar[index]]['tipo'];
          String tipo = isNumeric ? 'numerica' : 'escalar';
          return ListTile(
            title: Text('${listVar[index]} $tipo'),
            onTap: () async {
              formVar.isLoading = !formVar.isLoading;
              await showDialog(
                context: context,
                builder: (context) {
                  return DialogEditVar(
                    identVar: listVar[index],
                    formVar: formVar,
                  );
                },
              );
              formVar.isLoading = !formVar.isLoading;
            },
          );
        },
      ),
    );
  }
}
