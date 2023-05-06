class Hecho {
  String ident;
  dynamic valor;

  Hecho({required this.ident, required this.valor});

  factory Hecho.fromJson(Map<String, dynamic> json) => Hecho(
        ident: json["ident"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "ident": ident,
        "valor": valor,
      };
}
