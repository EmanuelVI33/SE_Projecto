import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/providers.dart';
import 'package:archivos_prueba/ui/auth_decoration.dart';
import 'package:archivos_prueba/widgets/dialog_custom.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddForm extends StatelessWidget {
  const DialogAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formLiteralProvider = Provider.of<FormLiteralProvider>(context);
    final formRuleProvider = Provider.of<FormRuleProvider>(context);
    final dataProvider = Provider.of<DataProvider>(context);
    bool isNumeric = formLiteralProvider.tipoVariable != null &&
        formLiteralProvider.tipoVariable!;

    bool isNotConclusion = !(formLiteralProvider.selectOption == 'conclusion');
    var formLiteralProvider2 = formLiteralProvider;
    bool selectVarNumeric = formLiteralProvider2.variableValue != '' &&
        formLiteralProvider.tipoVariable != null &&
        formLiteralProvider.tipoVariable!;
    var isEscalar = formLiteralProvider.tipoVariable != null &&
        !formLiteralProvider.tipoVariable! &&
        formLiteralProvider.id != null;
    return AlertDialog(
      title: Text(
        'Añadir ${formLiteralProvider.selectOption}',
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                  listVar:
                      selectVarNumeric ? Operadores.operAll : Operadores.oper,
                  formLiteralProvider: formLiteralProvider),
            if (isNumeric)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecorations(
                      hintText: '0',
                      labelText: 'valor',
                      prefixIcon: Icons.abc_rounded),
                  onChanged: (value) => formLiteralProvider.value = value,
                ),
              ),
            if (isEscalar)
              formLiteralProvider.value == ''
                  ? const Text('Selecione un valor')
                  : Text(formLiteralProvider.value),
            if (isEscalar)
              _SelectValorScalar(
                listVar: dataProvider.getValoresEsc(formLiteralProvider.id!),
                formLiteralProvider: formLiteralProvider,
              ),
            SizedBox(
              height: 10,
            ),
            if (isNotConclusion)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Negación'),
                  Checkbox(
                    value: formLiteralProvider.negacion,
                    onChanged: (value) => formLiteralProvider.negacion = value,
                  )
                ],
              )
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
                onPressed: () async {
                  bool conclucionNoValida =
                      formLiteralProvider.variableValue == '' ||
                          formLiteralProvider.value.isEmpty;
                  bool literalNoValido =
                      formLiteralProvider.operadorValue.isEmpty;

                  if (conclucionNoValida ||
                      (literalNoValido &&
                          formLiteralProvider.selectOption == 'premisa')) {
                    await showDialog(
                      context: context,
                      builder: (context) => const DialogCustom(
                          title: 'Error',
                          content: 'Verifique que esten los datos completos'),
                    );
                    return;
                  }

                  if (formLiteralProvider.selectOption == 'premisa') {
                    // Agregar premisa
                    Literal literal = Literal(
                        ident: formLiteralProvider.variableValue,
                        valor: formLiteralProvider.value,
                        neg: formLiteralProvider.negacion,
                        oprel: formLiteralProvider.operadorValue);
                    formRuleProvider.addLiteral(literal);
                  } else {
                    // Agregar conclusión
                    Hecho hecho = Hecho(
                        ident: formLiteralProvider.variableValue,
                        valor: formLiteralProvider.value);

                    formRuleProvider.setConclucion(hecho);
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
        final Map<String, dynamic> variable = dataProvider.variables;
        variable.forEach((key, value) {
          if (value['name'] == formLiteralProvider.variableValue) {
            formLiteralProvider.tipoVariable = value['tipo'];
            formLiteralProvider.id = key;
          }
        });
        formLiteralProvider.value = '';
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

class _SelectValorScalar extends StatelessWidget {
  const _SelectValorScalar({
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
        formLiteralProvider.value = value;
      },
    );
  }
}
