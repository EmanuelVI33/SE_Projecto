import 'package:archivos_prueba/models/models.dart';

class Numeric extends Variable {
  double valor;
  String rango;

  Numeric(String ident, this.valor, this.rango, {bool tipo = true})
      : super(ident, tipo);
}
