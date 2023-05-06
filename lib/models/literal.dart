import 'package:archivos_prueba/models/Hecho.dart';

class Literal extends Hecho {
  bool neg;
  String oprel;

  Literal({
    required String ident,
    required dynamic valor,
    required this.neg,
    required this.oprel,
  }) : super(ident: ident, valor: valor);

  Map<String, dynamic> toMap() =>
      {'ident': ident, 'valor': valor, 'neg': neg, 'oprel': oprel};

  factory Literal.fromJson(Map<String, dynamic> json) => Literal(
        ident: json['ident'],
        valor: json['valor'],
        oprel: json['oprel'],
        neg: json['neg'],
      );
}
