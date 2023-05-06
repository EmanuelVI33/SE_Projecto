import 'package:archivos_prueba/models/models.dart';

class Scale extends Variable {
  List<dynamic>? valores;

  Scale(
      {required int id, required String name, this.valores, bool tipo = false})
      : super(id, name, tipo);

  Map<String, dynamic> toMap() => {
        'id': super.id,
        'name': super.name,
        'tipo': super.tipo,
        'valores': valores,
      };

  factory Scale.fromJson(Map<String, dynamic> json) {
    print(' Valores ${json['valores']}');
    return Scale(
        id: json["id"],
        name: json["name"],
        tipo: json["tipo"],
        valores: json["valores"]);
  }
}
