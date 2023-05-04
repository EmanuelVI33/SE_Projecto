import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/ui/auth_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddForm extends StatelessWidget {
  const DialogAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    final formLiteralProvider = Provider.of<FormLiteralProvider>(context);
    final formRuleProvider = Provider.of<FormRuleProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);
    Map<String, dynamic> variable = dataProvider.variable;
    bool isNumeric = dataProvider.variable.isNotEmpty &&
        dataProvider.variable['tipo'] != null &&
        dataProvider.variable['tipo'];

    bool isNotConclusion = !(formLiteralProvider.selectOption == 'conclusion');
    return AlertDialog(
      title: Text(
        'Añadir ${formLiteralProvider.selectOption}',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(formLiteralProvider.variableValue != ''
                ? formLiteralProvider.variableValue
                : 'variables'),
            _SelectVar(
                dataProvider: dataProvider,
                formLiteralProvider: formLiteralProvider),
            if (isNotConclusion)
              Text(formLiteralProvider.operadorValue != ''
                  ? formLiteralProvider.operadorValue
                  : 'operador'),
            if (isNotConclusion)
              // Si no es una conclusión mostra los operadores
              _SelectOper(
                  // Solo si es una variable numerica, tiene acceso a todos los operadores
                  listVar: variable.isNotEmpty && variable['tipo']
                      ? Operadores.operAll
                      : Operadores.oper,
                  formLiteralProvider: formLiteralProvider),
            if (isNumeric)
              TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecorations(
                    hintText: '0',
                    labelText: 'valor',
                    prefixIcon: Icons.abc_rounded),
                onChanged: (value) => formLiteralProvider.value = value,
              ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Radio(
                    value: 'premisa',
                    groupValue: formLiteralProvider.selectOption,
                    onChanged: (value) =>
                        formLiteralProvider.selectOption = value),
                const Text('Premisa'),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: 'conclusion',
                    groupValue: formLiteralProvider.selectOption,
                    onChanged: (value) =>
                        formLiteralProvider.selectOption = value),
                const Text('Conclusión'),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (formLiteralProvider.selectOption == 'premisa') {
                    // Agregar premisa
                    Literal literal = Literal(
                        formLiteralProvider.variableValue,
                        formLiteralProvider.value,
                        false,
                        formLiteralProvider.operadorValue);
                    formRuleProvider.addLiteral(literal);
                  } else {
                    // Agregar conclusión
                    Hecho hecho = Hecho(formLiteralProvider.variableValue,
                        formLiteralProvider.value);

                    formRuleProvider.conclusion = hecho;
                  }

                  Navigator.pop(context);
                },
                child: Text('Añadir')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancelar')),
          ],
        ),
      ],
    );
  }
}

class _SelectVar extends StatelessWidget {
  const _SelectVar({
    Key? key,
    required this.dataProvider,
    required this.formLiteralProvider,
  }) : super(key: key);

  final DataProvider dataProvider;
  final FormLiteralProvider formLiteralProvider;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text('variables'),
      items: dataProvider.listVar.isNotEmpty
          ? dataProvider.listVar.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          : null, // si la lista está vacía, el menú desplegable será nulo
      onChanged: (value) {
        formLiteralProvider.variableValue = value;
        // Asignamos la variable
        dataProvider.variable = dataProvider.map[value];
      },
    );
  }
}

class _SelectOper extends StatelessWidget {
  const _SelectOper({
    Key? key,
    required this.listVar,
    required this.formLiteralProvider,
  }) : super(key: key);

  final List<String> listVar;
  final FormLiteralProvider formLiteralProvider;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      hint: const Text('operadores'),
      items: listVar.isNotEmpty
          ? listVar.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          : null, // si la lista está vacía, el menú desplegable será nulo
      onChanged: (value) {
        formLiteralProvider.operadorValue = value;
      },
    );
  }
}
