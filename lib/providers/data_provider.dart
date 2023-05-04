import 'dart:convert';

import 'package:archivos_prueba/models/models.dart';
import 'package:flutter/material.dart';

class FoundException implements Exception {
  const FoundException();
}

class DataProvider extends ChangeNotifier {
  Map<String, dynamic> map = {};
  Map<String, dynamic> _variable = {};
  int nroRegla = 0;
  List<String> _listVar = [];
  List<Scale> _listVarScale = [];
  List<Numeric> _listVarNumeric = [];

  void init() {
    // map.forEach((key, value) {
    //   if (value['tipo']) {
    //     // Si es numeric
    //     _listVarNumeric.add(Numeric(key, value['valor'], value['rango']));
    //   } else {
    //     _listVarScale.add(Scale(key, value['valores']));
    //   }
    // });

    // Asignar el número de regla
    if (map.containsKey('nroRegla')) {
      nroRegla = map['nroRegla'];
    } else {
      // Agregamos el número de regla
      map['nroRegla'] = 0;
    }
  }

  // Inicializa una variable
  void initVariable() {
    try {
      map.forEach((key, value) {
        String s = key[0];
        if (!(s.codeUnitAt(0) > 47 && s.codeUnitAt(0) < 58)) {
          // Si no empieza con número es una variable
          _variable = value;
          throw const FoundException();
        }
      });
    } catch (e) {
      return;
    }
  }

  // Añadir una variable escalar al objeto
  void addScale(Scale s) {
    map[s.ident] = <String, dynamic>{'valores': s.valores, 'tipo': s.tipo};
    notifyListeners();
  }

  // Añadir una variable escalar al objeto
  void addNumeric(Numeric n) {
    map[n.ident] = <String, dynamic>{
      'valor': n.valor,
      'rango': n.rango,
      'tipo': n.tipo
    };
    notifyListeners();
  }

  void addRule(Regla regla) {
    map[nroRegla.toString()] = {
      'premisa': regla.premisa,
      'conclusion': regla.hecho,
    };

    // Inclementar y agregar el número de regla
    nroRegla++;
    map['nroRegla'] = nroRegla;
  }

  // Obtener lista de valores de una variable escalar
  List<String> getValues() {
    return variable.isNotEmpty && !variable['tipo']
        ? variable['valores'] as List<String>
        : [];
  }

  // Map to String
  String toStr() {
    return jsonEncode(map);
  }

  // String to Map
  void toMap(String json) {
    map = jsonDecode(json) as Map<String, dynamic>;
    notifyListeners();
  }

  Map<String, dynamic> get variable => _variable;

  set variable(value) {
    variable = value;
    notifyListeners();
  }

  List<String> get listVar => _listVar;

  void setListVar() {
    _listVar = getListVar();
    notifyListeners();
  }

  List<String> getListVar() {
    List<String> list = [];
    map.forEach((key, value) {
      list.add(key);
    });
    return list;
  }
}
