import 'package:archivos_prueba/models/models.dart';

class Numeric extends Variable {
  double? valor; // Pueden ser valores nulos
  String? rango; // Rango

  Numeric(
      {required int id,
      required String name,
      this.valor,
      this.rango,
      bool tipo = true})
      : super(id, name, tipo);

  Map<String, dynamic> toMap() => {
        'id': super.id,
        'name': super.name,
        'tipo': super.tipo,
        'valor': valor,
        'rango': rango,
      };

  factory Numeric.fromJson(Map<String, dynamic> json) => Numeric(
      id: json["id"],
      name: json["name"],
      tipo: json["tipo"],
      valor: json["valor"],
      rango: json["rango"]);

  // factory Person.fromJson(Map<String, dynamic> json) => Person(
  //       name: json["name"],
  //       highScore: json["high score"],
  //   );
}
