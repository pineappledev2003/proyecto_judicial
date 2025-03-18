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

  set cambiarCodigoDespacho(String nuevoCodigo) {
    _codigoDespacho = nuevoCodigo;
  }

  set cambiarDepartamento(Departamento nuevoDepartamento) {
    _departamento = nuevoDepartamento;
  }

  set cambiarCiudad(Ciudad nuevaCiudad) {
    _ciudad = nuevaCiudad;
  }

  set cambiarNombreDespacho(String nuevoNombreDespacho) {
    _nombreDespachoJudicial = nuevoNombreDespacho;
  }

  set cambiarCategoria(String nuevaCategoria) {
    _categoria = nuevaCategoria;
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
