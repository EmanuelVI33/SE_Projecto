import 'package:archivos_prueba/models/hecho.dart';
import 'package:archivos_prueba/models/literal.dart';
import 'package:archivos_prueba/models/premisa.dart';

class Regla {
  int nro;
  List<Literal> premisa;
  Hecho hecho;

  Regla(this.nro, this.premisa, this.hecho);
}
