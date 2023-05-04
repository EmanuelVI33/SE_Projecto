import 'package:archivos_prueba/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDropDownButton extends StatefulWidget {
  final List<String> listVar;

  const MyDropDownButton({super.key, required this.listVar});

  @override
  State<MyDropDownButton> createState() => _MyDropDownButtonState();
}

class _MyDropDownButtonState extends State<MyDropDownButton> {
  dynamic option;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final dataProvider = Provider.of<DataProvider>(context);
    if (dataProvider.listVar.isNotEmpty) {
      option = dataProvider.listVar.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formLiteralProvider = Provider.of<FormLiteralProvider>(context);

    return DropdownButton(
      hint: const Text('Selecciona una opción'),
      items: widget.listVar.isNotEmpty
          ? widget.listVar.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
          : null, // si la lista está vacía, el menú desplegable será nulo
      onChanged: (value) {
        setState(() {
          option = value;
        });
      },
    );
  }
}
