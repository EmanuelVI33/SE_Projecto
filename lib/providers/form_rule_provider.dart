import 'package:archivos_prueba/models/models.dart';
import 'package:flutter/material.dart';

class FormRuleProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _dropdownValue = '';

  List<Literal> premisa = [];
  Hecho? conclusion;

  String get dropdownValue => _dropdownValue;

  set dropdownValue(value) {
    _dropdownValue = value;
    notifyListeners();
  }

  void addLiteral(Literal literal) {
    premisa.add(literal);
    notifyListeners();
  }

  void removePremisa(int index) {
    premisa.removeAt(index);
    notifyListeners();
  }

  // Hecho get conclusion => _conclusion;

  // set conclusion(value) => _conclusion = value;

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
