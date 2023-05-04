class Operadores {
  // static const Map<String, String> operadores = {
  //   'igual': "=",
  //   'diferente': "<>",
  //   'mayor': ">",
  //   'mayorIgual': ">=",
  //   'menor': "<",
  //   'menorIgual': "<=",
  // };
  static const List<String> oper = ['=', '<>'];
  static const List<String> operAll = ['=', '<>', '>', '>=', '<', '<='];
}

enum Oper {
  igual,
  diferente,
  mayor,
  mayorIgual,
  menor,
  menorIgual,
}
