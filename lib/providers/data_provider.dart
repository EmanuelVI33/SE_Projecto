import 'dart:convert';

import 'package:archivos_prueba/models/models.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier {
  Map<dynamic, dynamic> map = {'variables': {}, 'reglas': {}};
  int nroVariable = 0;
  int nroRegla = 0;
  List<String> _listVar = [];

  // Inicializa una variable
  void initVariable() {
    nroVariable = cantVariables();
    nroRegla = cantReglas();
    setListVar();
  }

  Map<String, dynamic> get variables => map['variables'];

  Map<String, dynamic> get reglas => map['reglas'];

  int cantVariables() {
    return variables.length;
  }

  int cantReglas() {
    return reglas.length;
  }

  // Añadir una variable escalar al objeto
  void addScale(Scale s) {
    int id;
    if (nroVariable == s.id) {
      // Añadir variable
      id = nroVariable;
    } else {
      // Ya existe la variable
      id = s.id;
    }

    map['variables'][id.toString()] = s.toMap();
    nroVariable = cantVariables();
    addListVar(s.name);

    notifyListeners();
  }

  // Añadir una variable escalar al objeto
  void addNumeric(Numeric n) {
    int id;
    if (nroVariable == n.id) {
      // Añadir variable
      id = nroVariable;
    } else {
      // Ya existe la variable
      id = n.id;
    }

    map['variables'][id.toString()] = n.toMap();
    nroVariable = cantVariables();
    addListVar(n.name);

    notifyListeners();
  }

  void addRule(Regla regla) {
    int id = nroRegla == regla.id ? nroRegla : regla.id;
    final r = regla.toJson();
    print(r);
    map['reglas'][id.toString()] = regla.toJson();
    nroRegla = cantReglas();
    notifyListeners();
  }

  void deleteVar(String id) {
    if (variables.containsKey(id)) {
      // Existe la variable
      final variable = variables[id];
      variables.remove(id);
      deleteListVar(variable["name"]);
      nroVariable = variables.length;
      notifyListeners();
    }
  }

  void deleteRule(String id) {
    if (reglas.containsKey(id)) {
      // Existe la variable
      reglas.remove(id);
      nroRegla = reglas.length;
      notifyListeners();
    }
  }

  Map<String, dynamic> getVariables() {
    return map['variables'];
  }

  dynamic getVar(int id) {
    return id == nroVariable ? {} : map['variables'][id];
  }

  Map<String, dynamic> getRelas() {
    return map['reglas'];
  }

  // Obtener lista de valores de una variable escalar
  // List<String> getValues() {
  //   return variable.isNotEmpty && !variable['tipo']
  //       ? variable['valores'] as List<String>
  //       : [];
  // }

  // Map to String
  String toStr() {
    return jsonEncode(map);
  }

  // String to Map
  void toMap(String json) {
    map = jsonDecode(json) as Map<String, dynamic>;
    notifyListeners();
  }

  List<String> get listVar => _listVar;

  set listVar(value) {
    listVar = value;
    notifyListeners();
  }

  List<String> getListVar() {
    List<String> list = [];
    // Obtener variables
    final variables = map['variables'];
    variables.forEach((key, value) {
      // Accedemos al nombre de los archivos
      list.add(value["name"]);
      // print('Values ${value["name"]}');
    });
    return list;
  }

  // Obtener valores de variable escalar
  List<String> getValoresEsc(String id) {
    List<dynamic> list = variables[id]['valores'];
    List<String> l = [];
    for (var elem in list) {
      String e = elem.toString();
      l.add(e);
    }
    return l;
  }

  void setListVar() {
    _listVar = getListVar();
    notifyListeners();
  }

  bool existeVar(String name) {
    return listVar.contains(name);
  }

  void addListVar(String variable) {
    if (!(listVar.contains(variable))) {
      // Si no esta repetido
      listVar.add(variable);
      notifyListeners();
    }
  }

  void deleteListVar(String variable) {
    if (listVar.contains(variable)) {
      listVar.remove(variable);
      notifyListeners();
    }
  }
}
