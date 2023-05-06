import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/data_provider.dart';
import 'package:archivos_prueba/providers/form_literal_provider.dart';
import 'package:archivos_prueba/providers/form_rule_provider.dart';
import 'package:archivos_prueba/widgets/dialog_rule.dart';
import 'package:archivos_prueba/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRule extends StatelessWidget {
  const AddRule({super.key});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    final formRuleProvider = Provider.of<FormRuleProvider>(context);
    final premisa = formRuleProvider.premisa;
    final size = MediaQuery.of(context).size;
    bool isNullConclusion = formRuleProvider.conclusion == null;
    int sizeConclucion = isNullConclusion ? 0 : 1;
    double sizeIf = 92;
    if (!isNullConclusion) {
      sizeIf += 50;
    }

    if (premisa.isNotEmpty) {
      sizeIf += (premisa.length * 50);
    }

    return Scaffold(
      appBar: const MyAppBar(title: 'Añadir regla'),
      body: SingleChildScrollView(
        child: Form(
            key: formRuleProvider.formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Añadir regla'),
                        Text('Regla n.- 10'),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    width: double.infinity,
                    height: sizeIf,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'IF',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                          textAlign: TextAlign.start,
                        ),
                        if (premisa.isEmpty)
                          const SizedBox(
                            height: 5,
                          ),
                        if (premisa.isNotEmpty)
                          Flexible(
                            fit: FlexFit.loose,
                            child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: premisa.length,
                                itemBuilder: (context, index) {
                                  var data =
                                      '${premisa[index].ident} ${premisa[index].oprel} ${premisa[index].valor}';
                                  if (premisa[index].neg) {
                                    data = '¬ $data';
                                  }

                                  return ListTile(
                                    title: Row(
                                      children: [
                                        if (index > 0)
                                          const Text('AND ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.purple)),
                                        Text(data,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.orange)),
                                      ],
                                    ),
                                    onTap: () async {
                                      final formLiteral =
                                          Provider.of<FormLiteralProvider>(
                                              context,
                                              listen: false);

                                      Literal literal = premisa[index];

                                      formLiteral.selectOption = 'premisa';
                                      formLiteral.variableValue = literal.ident;
                                      formLiteral.value = literal.valor;
                                      formLiteral.operadorValue = literal.oprel;
                                      formLiteral.negacion = literal.neg;

                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const DialogAddForm();
                                        },
                                      );
                                    },
                                    onLongPress: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) => DialogDeleteVar(
                                            function: () => formRuleProvider
                                                .deleteLiteral(index),
                                            title:
                                                '¿Deseas eliminar el literal?'),
                                      );
                                      // Quitar de la lista
                                    },
                                  );
                                }),
                          ),
                        const Text(
                          'ENTONCES',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                          textAlign: TextAlign.start,
                        ),
                        if (formRuleProvider.conclusion != null)
                          const SizedBox(
                            height: 5,
                          ),
                        if (formRuleProvider.conclusion != null)
                          TextButton(
                            onLongPress: () => showDialog(
                              context: context,
                              builder: (context) => DialogDeleteVar(
                                  function: () {
                                    formRuleProvider.setConclucion(null);
                                    Navigator.pop(context);
                                  },
                                  title: '¿Deseas eliminar la conclusión?'),
                            ),
                            onPressed: () async {
                              if (formRuleProvider.conclusion == null) {
                                return;
                              }
                              final formLiteral =
                                  Provider.of<FormLiteralProvider>(context,
                                      listen: false);

                              // Inicializamos la conclución
                              formLiteral.selectOption = 'conclusion';
                              Hecho conclusion = formRuleProvider.conclusion!;
                              formLiteral.variableValue = conclusion.ident;
                              formLiteral.value = conclusion.valor;
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return const DialogAddForm();
                                },
                              );
                            },
                            child: Text(
                              '    ${formRuleProvider.conclusion!.ident} = ${formRuleProvider.conclusion!.valor}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return const DialogAddForm();
                              },
                            );
                          },
                          child: const _MyButton(
                            color: Colors.white,
                            bgColor: Colors.blueAccent,
                            text: 'Añadir',
                          )),
                      TextButton(
                          onPressed: () async {
                            if (formRuleProvider.premisa.isNotEmpty &&
                                formRuleProvider.conclusion != null) {
                              Hecho hecho = formRuleProvider.conclusion!;

                              // Cumple los requisitos para ser una regla
                              Regla regla = Regla(
                                  id: dataProvider.nroRegla,
                                  premisa: premisa,
                                  hecho: hecho);

                              dataProvider.addRule(regla);

                              formRuleProvider.setConclucion(null);
                              formRuleProvider.premisa = [];

                              Navigator.pop(context);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return const DialogRule(
                                    title: 'Regla incorecta',
                                    content:
                                        'Debe agregar la premisa y la conclusión',
                                  );
                                },
                              );
                            }
                          },
                          child: const _MyButton(
                            color: Colors.white,
                            bgColor: Colors.green,
                            text: 'Guardar',
                          )),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class _MyButton extends StatelessWidget {
  final Color color;
  final Color bgColor;
  final String text;

  const _MyButton({
    Key? key,
    required this.color,
    required this.bgColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: bgColor, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: color,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: color),
                ),
              ],
            )),
      ],
    );
  }
}
