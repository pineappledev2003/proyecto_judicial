import 'package:proyecto_uml/models/ciudad.dart';
import 'package:proyecto_uml/models/departamento.dart';

class DespachoJudicial {
  String? _codigoDespacho;
  Departamento? _departamento;
  Ciudad? _ciudad;
  String? _nombreDespachoJudicial;
  String? _categoria;

  DespachoJudicial({
    required String codigoDespacho,
    required Departamento departamento,
    required Ciudad ciudad,
    required String nombreDespachoJudicial,
    required String categoria,
  }) {
    _codigoDespacho = codigoDespacho;
    _departamento = departamento;
    _ciudad = ciudad;
    _nombreDespachoJudicial = nombreDespachoJudicial;
    _categoria = categoria;
  }

  set cambiarCodigoDespacho(String nuevoCodigoDespacho) {
    _codigoDespacho = nuevoCodigoDespacho;
  }

  set cambiarNombreDespacho(String nuevoNombreDespacho) {
    _codigoDespacho = nuevoNombreDespacho;
  }

  set cambiarCategoria(String nuevaCategoria) {
    _codigoDespacho = nuevaCategoria;
  }

  String get obtenerCodigoDespacho {
    return _codigoDespacho!;
  }

  Departamento get obtenerDepartamento {
    return _departamento!;
  }

  Ciudad get obtenerCiudad {
    return _ciudad!;
  }

  String get obtenerNombreDespacho {
    return _nombreDespachoJudicial!;
  }

  String get obtenerCategoria {
    return _categoria!;
  }
}
