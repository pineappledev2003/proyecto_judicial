import 'package:proyecto_uml/models/ciudad.dart';

class Departamento {
  String? _nombreDepartamento;
  List<Ciudad> _ciudades = []; //agregacion: Lista de ciudades

  Departamento({required String nombreDepartamento, List<Ciudad>? ciuadades}) {
    _nombreDepartamento = nombreDepartamento;
    _ciudades = ciuadades ?? [];
  }

  set cambiarNombreDepartamento(String nuevoNombreDepartamento) {
    _nombreDepartamento = nuevoNombreDepartamento;
  }

  String get obtenerNombreDepartamento {
    return _nombreDepartamento!;
  }

  List<Ciudad> get obtenerListaCiudades {
    return _ciudades;
  }
}
