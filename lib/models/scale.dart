import 'package:archivos_prueba/models/models.dart';

class Scale extends Variable {
  List<String> valores;

  Scale(String ident, this.valores, {bool tipo = false}) : super(ident, tipo);
}
