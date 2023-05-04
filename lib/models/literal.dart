import 'package:archivos_prueba/models/Hecho.dart';

class Literal extends Hecho {
  bool neg;
  String oprel;

  Literal(String ident, dynamic valor, this.neg, this.oprel)
      : super(ident, valor);
}
