import 'package:archivos_prueba/models/literal.dart';
import 'package:flutter/cupertino.dart';

class FormLiteralProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _selectOption = 'premisa';
  String _variableValue = '';
  String _operadorValue = '';
  bool _negacion = false;
  String? id;
  bool? tipoVariable;
  String? valorEscalar;
  Literal? _literal;
  dynamic _value;

  String get selectOption => _selectOption;

  set selectOption(value) {
    _selectOption = value;
    notifyListeners();
  }

  String get variableValue => _variableValue;

  set variableValue(value) {
    _variableValue = value;
    notifyListeners();
  }

  String get operadorValue => _operadorValue;

  set operadorValue(value) {
    _operadorValue = value;
    notifyListeners();
  }

  String get value => _value;

  set value(value) {
    _value = value;
    notifyListeners();
  }

  Literal get literal => _literal!;

  set literal(value) {
    _literal = value;
    notifyListeners();
  }

  void setValorEscalar(value) {
    valorEscalar = value;
    notifyListeners();
  }

  bool get negacion => _negacion;

  set negacion(value) {
    _negacion = value;
    notifyListeners();
  }
}
