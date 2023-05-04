import 'package:flutter/material.dart';

class FormVariableProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String ident = "";
  dynamic valor = 0;
  List<String> valores = [];
  String rango = "";
  bool _isLoading = false;
  String path = 'my_file.txt';
  String _tipoVariable = 'numerica';
  double _sizeValores = 0;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String get tipoVariable => _tipoVariable;

  set tipoVariable(value) {
    _tipoVariable = value;
    notifyListeners();
  }

  double get sizeValores => _sizeValores;

  set sizeValores(value) {
    _sizeValores = value;
    notifyListeners();
  }

  void addValor(String item) {
    if (!valores.contains(item)) {
      valores.add(item);
      notifyListeners();
    }
  }

  void delValor(int index) {
    valores.removeAt(index);
  }

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
