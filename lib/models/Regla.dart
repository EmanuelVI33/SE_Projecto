import 'package:archivos_prueba/models/hecho.dart';
import 'package:archivos_prueba/models/literal.dart';
import 'package:archivos_prueba/models/premisa.dart';

class Regla {
  int id;
  List<Literal> premisa;
  Hecho hecho;

  Regla({required this.id, required this.premisa, required this.hecho});

  factory Regla.fromJson(Map<String, dynamic> json) => Regla(
        id: json["id"],
        premisa:
            List<Literal>.from(json["premisa"].map((x) => Literal.fromJson(x))),
        hecho: Hecho.fromJson(json["conclusion"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "premisa": List<dynamic>.from(premisa.map((x) => x.toMap())),
        "conclusion": hecho.toJson(),
      };
}
