import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/ui/auth_decoration.dart';
import 'package:archivos_prueba/widgets/dialog_change_var.dart';
import 'package:archivos_prueba/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddVariable extends StatelessWidget {
  const AddVariable({super.key});

  @override
  Widget build(BuildContext context) {
    final formVariable = Provider.of<FormVariableProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Añadir variable',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _LoginForm(
              dataProvider: dataProvider,
              formVariable: formVariable,
            ),
          ],
        ),
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
                      title: Text('$index ${formVariable.valores[index]}'),
                    );
                  },
                ),
              ),
            // if (formVariable.tipoVariable == 'numerica')
            //   TextFormField(
            //     initialValue: formVariable.rango,
            //     autocorrect: false,
            //     keyboardType: TextInputType.emailAddress,
            //     decoration: InputDecorations.authInputDecorations(
            //         hintText: '1:20',
            //         labelText: 'Rango',
            //         prefixIcon: Icons.alternate_email_rounded),
            //     onChanged: (value) => formVariable.rango = value,
            //   ),
            // const SizedBox(height: 30),
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
            const SizedBox(height: 10),
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
                        valor: double.parse(formVariable.valor),
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
    List<String> list = dataProvider.getListReglaVar(formVariable.name);
    await showDialog(
      context: context,
      builder: (context) {
        return DialogChangeVar(
          isEscalar: isEscalar,
          idVariable: int.parse(formVariable.id),
          name: formVariable.name,
          reglas: list,
        );
      },
    );
  }
}
