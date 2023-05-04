import 'package:archivos_prueba/models/models.dart';
import 'package:archivos_prueba/providers/data_provider.dart';
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    height: premisa.isNotEmpty
                        ? 72 * (premisa.length.toDouble() + 1)
                        : 110,
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
                                    onTap: () {},
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
                            height: 10,
                          ),
                        if (formRuleProvider.conclusion != null)
                          Text(
                            '    ${formRuleProvider.conclusion!.ident} = ${formRuleProvider.conclusion!.valor}',
                            style: const TextStyle(color: Colors.orange),
                            textAlign: TextAlign.center,
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
                              dataProvider.addRule(Regla(dataProvider.nroRegla,
                                  formRuleProvider.premisa, hecho));

                              formRuleProvider.conclusion = null;
                              formRuleProvider.premisa = [];

                              Navigator.pop(context);
                            } else {
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return const DialogRule();
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

// Flexible(
                //   flex: 1,
                //   child: Row(
                //     children: [
                //       ListTile(
                //         title: const Text(
                //           'Regla',
                //           style: TextStyle(fontSize: 10),
                //         ),
                //         leading: Radio(
                //           value: 'regla',
                //           groupValue: formRuleProvider.selectOption,
                //           onChanged: (value) {
                //             formRuleProvider.selectOption = value;
                //           },
                //         ),
                //       ),
                //       ListTile(
                //         title: const Text(
                //           'Conclusión',
                //           style: TextStyle(fontSize: 10),
                //         ),
                //         leading: Radio(
                //           value: 'conclusion',
                //           groupValue: formRuleProvider.selectOption,
                //           onChanged: (value) {
                //             formRuleProvider.selectOption = value;
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),


 // DropdownButton(
              //   hint: Text('Selecciona una opción'),
              //   items: dataProvider.listVar.isNotEmpty
              //       ? dataProvider.listVar
              //           .map<DropdownMenuItem<String>>((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(value),
              //           );
              //         }).toList()
              //       : null, // si la lista está vacía, el menú desplegable será nulo
              //   onChanged: (value) {
              //     formRuleProvider.dropdownValue = value;
              //   },
              // ),

// for (var i = 0; i <= premisa.length; i++)
//                   Container(
//                       child: TextButton(
//                           onPressed: () {}, child: Text(premisa[i].ident))),

// Expanded(
                //   child: ListView.builder(
                //     itemCount: formRuleProvider.premisa.length,
                //     itemBuilder: (context, index) {
                //       return TextButton(
                //           onPressed: () {},
                //           child: Text(formRuleProvider.premisa[index].ident));
                //     },
                //   ),
                // ),
